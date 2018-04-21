//
//  SeachResultListCellTest.swift
//  itunesSearch-CoreDataTests
//
//  Created by kawaharadai on 2018/04/15.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import XCTest
@testable import itunesSearch_CoreData

/**
 Recordデータを受け取って画面に表示するセルを生成するテスト
 */
final class SeachResultListCellTest: XCTestCase {
    
    let testDataSource = TestDataSource()
    var tableView: UITableView!
    var cell: SeachResultListCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "SeachBoardController", bundle: nil)
        guard let searchBoardVC = storyboard.instantiateViewController(withIdentifier: "SeachBoardController")
            as? SeachBoardController else {
                XCTFail("SeachBoardControllerのインスタンス生成に失敗")
                return
        }
        
        searchBoardVC.loadView()
        
        tableView = searchBoardVC.recordList
        tableView.dataSource = testDataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: SeachResultListCell.identifier,
                                              for: IndexPath(row: 0, section: 0)) as! SeachResultListCell
        
        testCellData(cell: cell)
    }
    
    /// セルにデータソースからデータが渡るかをテスト
    func testCellData(cell: SeachResultListCell) {
        let testData = TestData()
        let decoder = JSONDecoder()
        let mapResponse = try! decoder.decode(MapResponse.self, from: testData.getTestData())
        
        XCTAssertEqual(mapResponse.records.count, 1)
        cell.recordData = mapResponse.records.first
        XCTAssertEqual(cell.recordNameLabel.text, "どんなときも。")
        
    }
}

extension SeachResultListCellTest {
    
    final class TestDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
