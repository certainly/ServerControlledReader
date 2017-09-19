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
    var isMetaNode = false
    var kids: String
    var source: String
    
    init(withItem: MainListItem) {
        let sc =  withItem.source
        
//        if sc == SourceType.HN.rawValue {
//            self.displayText = isMetaNode ? withItem.other! : withItem.content!
//        }
        if sc == "V2" || sc == "HN" {
            isMetaNode = true
            
        }
        self.displayText = isMetaNode ? withItem.other! : withItem.content!
        
        self.kids = withItem.kids!
        self.source = withItem.source!
        
      
    }
    
}
