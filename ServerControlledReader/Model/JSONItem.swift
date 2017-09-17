//
//  JSONItem.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/17.
//  Copyright © 2017年 certainly. All rights reserved.
//

import Foundation

struct JSONItem: Codable {
    var cid: Int
    var content: String
    var time: Double
    var source: String
    var kids: String
    var other: String
}
