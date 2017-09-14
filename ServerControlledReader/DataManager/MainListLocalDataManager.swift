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
    
    
    func insertMainListItem(commentURL: String, type: String ) -> MainListItem? {
        guard let item = NSEntityDescription.insertNewObject(forEntityName: "MainListItem", into: backgroundContext) as? MainListItem else { return nil }
        item.commentURL = commentURL
        item.type = type
        return item
    }
    
    
    func retrieveMainList()  -> [MainListItem] {
        let request: NSFetchRequest<MainListItem> = MainListItem.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [MainListItem]()
        
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
        insertMainListItem(commentURL: "df", type: "dd")
         insertMainListItem(commentURL: "df22", type: "dd")
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
