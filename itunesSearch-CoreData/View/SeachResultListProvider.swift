//
//  SeachResultListProvider.swift
//  itunesSearch-CoreData
//
//  Created by kawaharadai on 2018/04/14.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import UIKit

class SeachResultListProvider: NSObject {
    var records = [MapResponse.Record]()
}

extension SeachResultListProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeachResultListCell.identifier,
                                                       for: indexPath) as? SeachResultListCell else {
            fatalError("cell is nil")
        }
        cell.recordData = records[indexPath.row]
        return cell
    }
}
