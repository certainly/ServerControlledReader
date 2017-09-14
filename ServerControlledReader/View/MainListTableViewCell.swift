//
//  MainListTableViewCell.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/14.
//  Copyright © 2017年 certainly. All rights reserved.
//

import UIKit

class MainListTableViewCell: UITableViewCell {

    
    var cellModel: MainListViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    func bindViewModel() {
        textLabel?.text = cellModel?.displayText
    }

}
