//
//  TestData.swift
//  itunesSearch-CoreDataTests
//
//  Created by kawaharadai on 2018/04/16.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import XCTest

/**
 UT用のテストデータを返す
 */
final class TestData: XCTestCase {
    func getTestData() -> Data {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "SampleAPIResponse",
                                   ofType: "json")
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path!))
        
        return jsonData
    }
}
