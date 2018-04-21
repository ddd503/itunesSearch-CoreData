//
//  RecordDataDaoTest.swift
//  itunesSearch-CoreDataTests
//
//  Created by kawaharadai on 2018/04/15.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import XCTest
@testable import itunesSearch_CoreData

/**
 アイコン画像を保存する処理と取得する処理のテスト
 */
final class RecordDataDaoTest: XCTestCase {
    
    private let testEntityName = "UTRecordData"
    private let testTrackId = 295587704
    private let testImageURL = "https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/87/e4/25/87e42562-0158-f0c9-2d93-3512b68dc81b/source/100x100bb.jpg"
    
    override func setUp() {
        super.setUp()
        DeleteTestEntity.allDelete(entityName: testEntityName)
    }
    
    override func tearDown() {
        super.tearDown()
        DeleteTestEntity.allDelete(entityName: testEntityName)
    }
    
    /// CoreDataにテストデータを保存　→ 保存されているデータを取得 → 照合する
    func testCoreDataAction() {
        RecordDataDao.save(entityName: testEntityName,
                           trackId: testTrackId,
                           imageURL: testImageURL)
        
        /// trackIdを元にレコードデータを取得、画像URLを照合する
        let recordData = RecordDataDao.seach(entityName: testEntityName,
                                             format: "trackId == %ld",
                                             trackId: testTrackId)
        
        XCTAssertEqual(recordData?.value(forKey: "trackId") as! Int, testTrackId)
        XCTAssertEqual(recordData?.value(forKey: "imageURL") as! String, testImageURL)
        
    }
}
