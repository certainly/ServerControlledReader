//
//  MainListItem+CoreDataProperties.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/17.
//  Copyright © 2017年 certainly. All rights reserved.
//
//

import Foundation
import CoreData


extension MainListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainListItem> {
        return NSFetchRequest<MainListItem>(entityName: "MainListItem")
    }

    @NSManaged public var cid: Int64
    @NSManaged public var content: String?
    @NSManaged public var time: Double
    @NSManaged public var source: String?
    @NSManaged public var kids: String?
    @NSManaged public var other: String?

}
