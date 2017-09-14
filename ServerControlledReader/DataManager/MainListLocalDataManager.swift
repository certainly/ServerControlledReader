//
//  MainListLocalDataManager.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/14.
//  Copyright © 2017年 certainly. All rights reserved.
//

import Foundation

class MainListLocalDataManager {
    func retrieveMainList() throws -> [MainListItem] {
        return retrieveMainListStub()
    }
    
    private func retrieveMainListStub() -> [MainListItem] {
        let rz = [MainListItem] ()
//        let data1 = MainListItem(entity: <#T##NSEntityDescription#>, insertInto: <#T##NSManagedObjectContext?#>)
        return rz
    }
}
