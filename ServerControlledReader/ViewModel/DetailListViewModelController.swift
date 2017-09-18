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
    
    var needRefresh: Bool {
        return detailListViewModelList.count == 1 && ( detailListViewModelList[0].source == "V2" || detailListViewModelList[0].kids.characters.count > 0 )
    }
    
    
    var itemsCount: Int {
        return detailListViewModelList.count
    }
    
    func viewModel(at index: Int) -> DetailListViewModel {
        return detailListViewModelList[index]
    }
    
    func retrieveDetailList(cid: String, _ success: (() -> Void)?, failure: ( () -> Void)?)  {
        do{
            //            dataManager.reset()
            //            dataManager.makeFakeData()
            
            let list = try  dataManager.retrieveDetailList(cid)
            
            //            if list.count == 0 {
            //                print("empty list!")
            //                fetchFromServer(success)
            //                return
            //            }

            
            detailListViewModelList.removeAll()
            detailListViewModelList = list.map(){DetailListViewModel(withItem: $0 ) }
            success?()
            print("retrieve over")
        } catch {
            print(error)
            failure?()
        }
    }
    func refreshDetailList(cid: String, _ success: (() -> Void)?, failure: ( () -> Void)?) {
        
    }
}
