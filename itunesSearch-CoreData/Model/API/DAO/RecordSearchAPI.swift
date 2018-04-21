//
//  AppDelegate.swift
//  skillup-itunes
//
//  Created by kawaharadai on 2018/04/21.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import Foundation

/// APIステータス
enum RecordSearchAPIStatus {
    case successLoad(records: [MapResponse.Record])
    case offline
    case emptyData
    case error
}

/// コントローラーへの通知プロトコル
protocol RecordSearchAPIDelegate: class {
    func searchResult(result: RecordSearchAPIStatus)
}

/**
 APIと通信しAPIステータスをコントローラーへ返す
 */
final class RecordSearchAPI {
    
    weak var recordSearchAPIDelegate: RecordSearchAPIDelegate?
    
    func requestAPI(seachWord: String) {
        
        if !Network.onLineNetwork() {
            recordSearchAPIDelegate?.searchResult(result: .offline)
            return
        }
        
        let parameters = SearchParamsBuilder.create(searchWord: seachWord)
        
        let router = Router.searchAPI(parameters)
        
        APIClient.request(router: router) { [weak self] result in
            switch result {
            case .success(let jsonData):
                do {
                    let decoder = JSONDecoder()
                    let mapResponse = try decoder.decode(MapResponse.self, from: jsonData)
                    if mapResponse.records.isEmpty {
                        self?.recordSearchAPIDelegate?.searchResult(result: .emptyData)
                    } else {
                        self?.recordSearchAPIDelegate?.searchResult(result: .successLoad(records: mapResponse.records))
                    }
                } catch let error {
                    print("error: \(error.localizedDescription)")
                    self?.recordSearchAPIDelegate?.searchResult(result: .error)
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                self?.recordSearchAPIDelegate?.searchResult(result: .error)
            }
        }
    }
}
