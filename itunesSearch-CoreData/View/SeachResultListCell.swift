//
//  SeachResultListCell.swift
//  itunesSearch-CoreData
//
//  Created by kawaharadai on 2018/04/14.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import Kingfisher
import UIKit

class SeachResultListCell: UITableViewCell {
    
    @IBOutlet weak var recordImageView: UIImageView!
    @IBOutlet weak var recordNameLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var recordData: MapResponse.Record? {
        didSet {
            setRecordData(recordData: recordData)
        }
    }
    
    func setRecordData(recordData: MapResponse.Record?) {
        /// 曲名を入れる
        self.recordNameLabel.text = recordData?.trackName
        
        /// CoreDataに保存された画像URLがある場合は、そちらを使う
        if let trackId = recordData?.trackId,
            let seachedRecordData = RecordDataDao.seach(entityName: "RecordData",
                                                        format: "trackId == %ld",
                                                        trackId: trackId),
            let imageURLString = seachedRecordData.value(forKey: "imageURL") as? String {
            self.recordImageView.kf.setImage(with: URL(string: imageURLString),
                                             placeholder: #imageLiteral(resourceName: "noimage"))
            return
        }
        
        /// CoreDataに保存された画像URLがない場合は、URLからダウンロードする
        if let imageURLString = recordData?.artworkUrl100 {
            self.recordImageView.kf.setImage(with: URL(string: imageURLString),
                                             placeholder: #imageLiteral(resourceName: "noimage"))
            
            guard let trackId = recordData?.trackId else {
                print("not save imageURL becouse nothing trackId")
                return
            }
            /// CoreDataに画像URLを保存する
            RecordDataDao.save(entityName: "RecordData", trackId: trackId,
                               imageURL: imageURLString)
        } else {
            /// 画像URLが存在しない
            self.recordImageView.image = #imageLiteral(resourceName: "noimage")
        }
    }
}
