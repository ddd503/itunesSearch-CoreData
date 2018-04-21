//
//  RecordDataDao.swift
//  itunesSearch-CoreData
//
//  Created by kawaharadai on 2018/04/14.
//  Copyright © 2018年 kawaharadai. All rights reserved.
//

import CoreData
import UIKit

class RecordDataDao {
    
    // MARK: - Core Data stack
    static func persistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "itunesSearch_CoreData")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    /// 検索条件を指定して取得
    static func seach(entityName: String, format: String, trackId: Int) -> NSManagedObject? {
        
        var fetchedArray = [NSManagedObject]()
        
        let managedContext = RecordDataDao.persistentContainer().viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        let predicate = NSPredicate(format: format, trackId)
        fetchRequest.predicate = predicate
        
        do {
            fetchedArray = try managedContext.fetch(fetchRequest)
            guard !fetchedArray.isEmpty else {
                return nil
                
            }
            return fetchedArray[0]
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// 新規保存
    static func save(entityName: String, trackId: Int, imageURL: String) {
        
        let managedContext = RecordDataDao.persistentContainer().viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName,
                                                      in: managedContext) else {
                                                        print("NSEntityDescription is nil")
                                                        return
        }
        
        let managerObject = NSManagedObject(entity: entity,
                                            insertInto: managedContext)
        
        managerObject.setValue(trackId, forKeyPath: "trackId")
        managerObject.setValue(imageURL, forKeyPath: "imageURL")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
}
