//
//  ServerControlledReaderTests.swift
//  ServerControlledReaderTests
//
//  Created by certainly on 2017/9/13.
//  Copyright © 2017年 certainly. All rights reserved.
//

import XCTest
import CoreData

@testable import ServerControlledReader

class ServerControlledReaderTests: XCTestCase {
    
    var sut: MainListLocalDataManager!
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ServerControlledReader", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        })
        return container
    }()
    
    func initStubs() {
        func insertItem(commentURL: String, type: String) -> MainListItem? {
            let obj = NSEntityDescription.insertNewObject(forEntityName: "MainListItem", into: mockPersistantContainer.viewContext)
            obj.setValue(commentURL, forKey: "commentURL")
            obj.setValue(type, forKey: "type")
            
            return obj as? MainListItem
        }
        
        _ = insertItem(commentURL: "1", type: "twitter")
        _ = insertItem(commentURL: "2", type: "twitter2")
        _ = insertItem(commentURL: "3", type: "twitter3")
        _ = insertItem(commentURL: "4", type: "twitter4")
        _ = insertItem(commentURL: "5", type: "twitter5")
        
        do {
            try mockPersistantContainer.viewContext.save()
        } catch  {
            print("create fakes error \(error)")
        }
    }
    
    func flushData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "MainListItem")
        let objs = try! mockPersistantContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer.viewContext.delete(obj)
        }
        try! mockPersistantContainer.viewContext.save()
        
    }
    
    override func setUp() {
        super.setUp()
        initStubs()
        sut = MainListLocalDataManager(container: mockPersistantContainer)
        //Listen to the change in context
        NotificationCenter.default.addObserver(self, selector: #selector(contextSaved(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave , object: nil)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
         NotificationCenter.default.removeObserver(self)
        flushData()
        super.tearDown()
    }
    
    func test_create_item()  {
        let commentURL = "http://ddd"
        let type = "v2ex"
        
        let item = sut.insertMainListItem(commentURL: commentURL, type: type)
        
        XCTAssertNotNil(item)
    }
    
    func test_fetch_all_todo()  {
        let results = sut.retrieveMainList()
        XCTAssertEqual(results.count, 5)
    }
    
    func test_remove_todo() {
        
        //Given a item in persistent store
        let items = sut.retrieveMainList()
        let item = items[0]
        
        let numberOfItems = items.count
        
        //When remove a item
        sut.remove(objectID: item.objectID)
        sut.save()
        
        //Assert number of item - 1
        XCTAssertEqual(numberOfItemsInPersistentStore(), numberOfItems-1)
        
    }
    
    func test_save() {

        //Give a todo item
        let commentURL = "http://test"
        let type = "hack"

        _ = expectationForSaveNotification()

        _ = sut.insertMainListItem(commentURL: commentURL, type: type)
        //When save
        sut.save()

        //Assert save is called via notification (wait)
        waitForExpectations(timeout: 10, handler: nil)

    }
    
    //MARK: Convinient function for notification
    var saveNotificationCompleteHandler: ((Notification)->())?
    
    func expectationForSaveNotification() -> XCTestExpectation {
        let expect = expectation(description: "Context Saved")
        waitForSavedNotification { (notification) in
            expect.fulfill()
        }
        return expect
    }
    
    func waitForSavedNotification(completeHandler: @escaping ((Notification)->()) ) {
        saveNotificationCompleteHandler = completeHandler
    }
    
    func contextSaved( notification: Notification ) {
        saveNotificationCompleteHandler?(notification)
    }
    
    func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MainListItem")
        let results = try! mockPersistantContainer.viewContext.fetch(request)
        return results.count
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
