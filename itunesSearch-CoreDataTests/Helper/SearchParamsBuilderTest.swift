//
//  SearchParamsBuilderTest.swift
//  itunesSearch-CoreDataTests
//
//  Created by kawaharadai on 2018/04/15.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import XCTest
@testable import itunesSearch_CoreData

/**
 検索ワードからAPIへのリクエストパラメータを生成するテスト
 */
final class SearchParamsBuilderTest: XCTestCase {

    func testCreate() {
        
        let searchWord = "槇原敬之"
        let params = SearchParamsBuilder.create(searchWord: searchWord) as! [String: String]
        
        XCTAssertEqual(params["term"], "槇原敬之")
        XCTAssertEqual(params["country"], "JP")
        XCTAssertEqual(params["lang"], "ja_jp")
        XCTAssertEqual(params["media"], "music")
    }
    
}
