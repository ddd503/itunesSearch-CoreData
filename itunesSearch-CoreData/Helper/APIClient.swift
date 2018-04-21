//
//  APIClient.swift
//  itunesSearch-CoreData
//
//  Created by kawaharadai on 2018/04/14.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import Alamofire

enum Result {
    case success(Data)
    case failure(Error)
}

final class APIClient {
    /**
     APIと通信し成功時、レスポンスをData型で返す
     */
    static func request(router: Router,
                        completionHandler: @escaping (Result) -> () = { _ in }) {
        
        Alamofire.request(router).responseData { response in
            
            let statusCode = response.response?.statusCode
            print("HTTP status code: \(String(describing: statusCode))")
            
            switch response.result {
                
            case .success(let value):
                completionHandler(Result.success(value))
                return
                
            case .failure:
                if let error = response.result.error {
                    completionHandler(Result.failure(error))
                    return
                }
            }
        }
    }
}
