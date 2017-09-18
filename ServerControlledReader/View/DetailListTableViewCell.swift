//
//  DetailListTableViewCell.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/18.
//  Copyright © 2017年 certainly. All rights reserved.
//

import UIKit

class DetailListTableViewCell: UITableViewCell {

    var cellModel: DetailListViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    func bindViewModel() {
        textLabel?.text = cellModel?.displayText
    }

}
