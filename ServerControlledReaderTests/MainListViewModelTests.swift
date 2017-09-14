//
//  MainListViewModelTests.swift
//  ServerControlledReaderTests
//
//  Created by certainly on 2017/9/14.
//  Copyright © 2017年 certainly. All rights reserved.
//

import XCTest
@testable import ServerControlledReader

class MainListViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        print("ddc")
//        let main = MainListItem()
//        main.commentURL = "http://ddd"
        let mainlistViewModel = MainListViewModel(displayText: "test")
//        XCTAssertNotNil(mainlistViewModel,"The view model should not be nil")
        
        XCTAssertEqual(mainlistViewModel.displayText, "test"," not equal in mainvm")
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
