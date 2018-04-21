//
//  SeachBoardController.swift
//  itunesSearch-CoreData
//
//  Created by kawaharadai on 2018/04/14.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import SVProgressHUD
import UIKit

class SeachBoardController: UIViewController {
    
    @IBOutlet weak  var recordList: UITableView!
    @IBOutlet weak  var recordSearchBar: UISearchBar!
    @IBOutlet weak  var nothingRecordView: UIView!
    
    private let recordSearchAPI = RecordSearchAPI()
    private let provider = SeachResultListProvider()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        recordSearchAPI.recordSearchAPIDelegate = self
        setupRecordList()
        setupSearchBar()
    }
    
    private func setupRecordList() {
        recordList.dataSource = provider
        recordList.scrollsToTop = true
    }
    
    private func setupSearchBar() {
        recordSearchBar.delegate = self
        if let textfield = recordSearchBar.value(forKey: "searchField") as? UITextField {
            textfield.clearButtonMode = .whileEditing
        }
    }
    
    // MARK: - Private
    private func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - RecordSearchAPIDelegate
extension SeachBoardController: RecordSearchAPIDelegate {
    
    func searchResult(result: RecordSearchAPIStatus) {
        
        navigationItem.searchController?.isActive = false
        
        switch result {
        case .successLoad(let records):
            provider.records = []
            provider.records = records
            navigationItem.title = records[0].artistName ?? "不明"
            self.recordList.setContentOffset(CGPoint(x: 0, y: -self.recordList.contentInset.top),
                                             animated: false)
            DispatchQueue.main.async {
                self.recordList.reloadData()
                self.nothingRecordView.isHidden = true
            }
        case .offline:
            showAlert(title: "警告",
                      message: "通信環境の良い場所で再度お試しください。")
        case .emptyData:
            nothingRecordView.isHidden = false
            navigationItem.title = "音楽検索"
            showAlert(title: "該当なし",
                      message: "該当する音楽データはありません。")
        case .error:
            showAlert(title: "失敗",
                      message: "データ検索に失敗しました。")
        }
        
        SVProgressHUD.dismiss()
    }
}

// MARK: - UISearchBarDelegate
extension SeachBoardController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text else {
            return
        }
        SVProgressHUD.show()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        recordSearchAPI.requestAPI(seachWord: searchWord)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.canResignFirstResponder {
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.resignFirstResponder()
        }
    }
}
