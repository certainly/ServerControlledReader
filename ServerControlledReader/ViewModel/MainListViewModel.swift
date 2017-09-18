//
//  MainListViewModel.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/14.
//  Copyright © 2017年 certainly. All rights reserved.
//

public struct MainListViewModel {
    var displayText: String
    var cid: String
    init(withItem item: MainListItem ) {
        self.displayText = item.content ?? "nil"
        self.cid = String(item.cid)
    }
//    init(displayText: String){
//        self.displayText = displayText
//    }
}
