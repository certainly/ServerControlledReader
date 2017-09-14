//
//  MainListItem+CoreDataClass.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/13.
//  Copyright © 2017年 certainly. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MainListItem)
public class MainListItem: NSManagedObject {
    var displayMsg: String {
        get {
            var rz = ""
            if let commentURL = commentURL {
                rz += commentURL
            }
            if let type = type {
                rz += type
            }
            return rz
        }
    }
}
