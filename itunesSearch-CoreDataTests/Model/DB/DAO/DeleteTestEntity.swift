//
//  DeleteTestEntity.swift
//  itunesSearch-CoreDataTests
//
//  Created by kawaharadai on 2018/04/15.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import CoreData
import UIKit
@testable import itunesSearch_CoreData

/**
 UT用のテストEntityのデータを削除するクラス
 */
final class DeleteTestEntity: NSObject {
    /// 指定のNSManagedObjectを削除
    static func delete(record: NSManagedObject) {
        
        let managedContext = RecordDataDao.persistentContainer().viewContext
        
        managedContext.delete(record)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
    /// 指定したEntity内のデータを全件削除
    static func allDelete(entityName: String) {
        
        let managedContext = RecordDataDao.persistentContainer().viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
        
    }
}
