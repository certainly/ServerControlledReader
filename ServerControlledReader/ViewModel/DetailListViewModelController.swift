//
//  DetailListViewModelController.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/18.
//  Copyright © 2017年 certainly. All rights reserved.
//

import Foundation

class DetailListViewModelController {
    
    fileprivate var detailListViewModelList: [DetailListViewModel] = []
    fileprivate var dataManager = MainListLocalDataManager()
    
    var itemsCount: Int {
        return detailListViewModelList.count
    }
    
    func viewModel(at index: Int) -> DetailListViewModel {
        return detailListViewModelList[index]
    }
}
