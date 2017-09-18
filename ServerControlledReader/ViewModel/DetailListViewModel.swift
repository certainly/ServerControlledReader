//
//  DetailListViewModel.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/18.
//  Copyright © 2017年 certainly. All rights reserved.
//

import Foundation

class DetailListViewModel {
    var displayText: String
    init(withItem: MainListItem) {
        self.displayText = withItem.other ?? "nil"
    }
    
}
