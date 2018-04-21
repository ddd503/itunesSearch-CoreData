//
//  SeachBoardControllerTest.swift
//  itunesSearch-CoreDataTests
//
//  Created by kawaharadai on 2018/04/15.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import XCTest
@testable import itunesSearch_CoreData

/**
 SeachBoardControllerで行うデータハンドリングの確認
 */
final class SeachBoardControllerTest: XCTestCase {
    
    let provider = SeachResultListProvider()
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "SeachBoardController", bundle: nil)
        guard let searchBoardVC = storyboard.instantiateViewController(withIdentifier: "SeachBoardController")
            as? SeachBoardController else {
                XCTFail("SeachBoardControllerのインスタンス生成に失敗")
                return
        }
        
        searchBoardVC.loadView()
        searchBoardVC.viewDidLoad()
        setupTest(vc: searchBoardVC)
    }
    
    func setupTest(vc: SeachBoardController) {
        XCTAssertTrue(vc.recordList.scrollsToTop)
        XCTAssertNotNil(vc.recordList.dataSource)
        XCTAssertNotNil(vc.recordSearchBar.delegate)
        let textfield = vc.recordSearchBar.value(forKey: "searchField") as! UITextField
        XCTAssertEqual(textfield.clearButtonMode, .whileEditing)
    }
}
