//
//  RecordsTest.swift
//  itunesSearch-CoreDataTests
//
//  Created by kawaharadai on 2018/04/15.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import XCTest
@testable import itunesSearch_CoreData

/**
 Jsonデータをマッピングするテスト
 */
final class RecordsTest: XCTestCase {
    
    let testData = TestData()
    
    func testMapping() {
        let testJsonData = testData.getTestData()
        let decoder = JSONDecoder()
        let mapResponse = try! decoder.decode(MapResponse.self, from: testJsonData)
        
        XCTAssertEqual(mapResponse.records.count, 1)
        XCTAssertEqual(mapResponse.records[0].artistName, "槇原敬之")
        XCTAssertEqual(mapResponse.records[0].trackName, "どんなときも。")
        XCTAssertEqual(mapResponse.records[0].trackId, 295587704)
        XCTAssertEqual(mapResponse.records[0].artworkUrl100, "https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/87/e4/25/87e42562-0158-f0c9-2d93-3512b68dc81b/source/100x100bb.jpg")
    }
}
