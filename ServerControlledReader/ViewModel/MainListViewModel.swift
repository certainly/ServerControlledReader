//
//  MainListViewModel.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/14.
//  Copyright © 2017年 certainly. All rights reserved.
//

public struct MainListViewModel {
    var displayText: String
    init(withItem item: MainListItem ) {
        self.displayText = item.content ?? "nil"
    }
    init(displayText: String){
        self.displayText = displayText
    }
}
