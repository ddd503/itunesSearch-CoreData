//
//  RecordSearchAPITest.swift
//  itunesSearch-CoreDataTests
//
//  Created by kawaharadai on 2018/04/15.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import XCTest
@testable import itunesSearch_CoreData

/**
 API通信して非同期処理で受け取ったレスポンスの種類によって処理を分岐するテスト
 */
final class RecordSearchAPITest: XCTestCase {
    
    let recordSearchAPI = RecordSearchAPI()
    let delegateTest = RecordSearchResponseTest()
    
    override func setUp() {
        super.setUp()
        recordSearchAPI.recordSearchAPIDelegate = delegateTest
    }
    
    override func tearDown() {
        super.tearDown()
        recordSearchAPI.recordSearchAPIDelegate = nil
    }
    
    func testRequestAPI() {
        let expectation = self.expectation(description: "槇原敬之と入力した時のテスト")
        delegateTest.asyncExpectation = expectation
        
        recordSearchAPI.requestAPI(seachWord: "槇原敬之")
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("タイムアウトエラー(1秒): \(error)")
            }
            
            if let result = self.delegateTest.result {
                
                switch result {
                case .successLoad(let records):
                    XCTAssertNotNil(result)
                    XCTAssertTrue(records.count > 0)
                case .offline:
                    XCTFail("オフライン")
                case .emptyData:
                    XCTFail("データが0件")
                case .error:
                    XCTFail("エラー")
                }
            }
        }
    }
    
}
