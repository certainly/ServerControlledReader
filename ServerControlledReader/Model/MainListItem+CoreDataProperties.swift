//
//  MainListItem+CoreDataProperties.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/13.
//  Copyright © 2017年 certainly. All rights reserved.
//
//

import Foundation
import CoreData


extension MainListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainListItem> {
        return NSFetchRequest<MainListItem>(entityName: "MainListItem")
    }

    @NSManaged public var commentURL: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?

}
