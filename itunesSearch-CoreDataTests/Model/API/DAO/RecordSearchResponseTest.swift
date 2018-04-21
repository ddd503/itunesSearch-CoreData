//
//  RecordSearchResponseTest.swift
//  itunesSearch-CoreDataTests
//
//  Created by kawaharadai on 2018/04/15.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import XCTest
@testable import itunesSearch_CoreData

/**
 非同期でAPIからのレスポンス結果を受けるテスト
 */
final class RecordSearchResponseTest: RecordSearchAPIDelegate {
    
    var result: RecordSearchAPIStatus?
    var asyncExpectation: XCTestExpectation?
    
    func searchResult(result: RecordSearchAPIStatus) {
        guard let expectation = asyncExpectation else {
            XCTFail("Delegate is nil")
            return
        }
        
        self.result = result
        /// 期待値通りに処理完了
        expectation.fulfill()
    }
}
