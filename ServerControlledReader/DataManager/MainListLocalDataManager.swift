//
//  MainListLocalDataManager.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/14.
//  Copyright © 2017年 certainly. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MainListLocalDataManager {
    
    let persistentContainer: NSPersistentContainer!
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    convenience init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    
    func insertMainListItem(cid: Int64, content: String, time: Double, source: String, kids: String, other: String) -> MainListItem? {
        guard let item = NSEntityDescription.insertNewObject(forEntityName: "MainListItem", into: backgroundContext) as? MainListItem else { return nil }
        item.cid = cid
        item.content = content
        item.time = time
        item.source = source
        item.kids = kids
        item.other = other
        return item
    }
    
    
    func retrieveMainList() throws  -> [MainListItem] {
        let request: NSFetchRequest<MainListItem> = MainListItem.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(MainListItem.time), ascending: false)
        request.sortDescriptors = [sort]
        let results = try backgroundContext.fetch(request)
        return results 
        
    }
    
    func reset()  {
        let request: NSFetchRequest<MainListItem> = MainListItem.fetchRequest()
        let results = try? backgroundContext.fetch(request)
        for item in results! {
            backgroundContext.delete(item)
        }
        save()
    }

    func remove( objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
        
    }
    
    func makeFakeData() {
//        _ = insertMainListItem(commentURL: "df", type: "dd")
//        _ = insertMainListItem(commentURL: "df22", type: "dd")
        save()
    }
    

    
    func insertDataArray(_ array: [JSONItem]) {
       reset()
        for item in array {
            _ = insertMainListItem(cid: Int64(item.cid), content: item.content, time: item.time, source: item.source, kids: item.kids, other: item.other)
        }
        save()
    }
    
    func  save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
    

}
