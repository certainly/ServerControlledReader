//
//  MainListViewModelController.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/14.
//  Copyright © 2017年 certainly. All rights reserved.
//

import Foundation

class MainListViewModelController {
    fileprivate var mainlistViewModelList: [MainListViewModel] = []
    fileprivate var dataManager = MainListLocalDataManager()
    var itemsCount: Int {
        return mainlistViewModelList.count
    }
    
    func retrieveMainLists(_ success: (() -> Void)?, failure: ( () -> Void)?)  {
        do{
            
//            let list = try dataManager.retrieveMainList()
            mainlistViewModelList =  retrieveMainListsStub()
            success?()
        } catch {
            print(error)
            failure?()
        }
    }
    
    private func  retrieveMainListsStub()   -> [MainListViewModel] {
        var rz = [MainListViewModel]()
        let data1 = MainListViewModel(displayText: "testdata111")
        let data2 = MainListViewModel(displayText: "testdata2222")
        let data3 = MainListViewModel(displayText: "testdata3")
        rz.append(data1)
        rz.append(data2)
        rz.append(data3)
        return rz
    }
    
    func viewModel(at index: Int) -> MainListViewModel {
        return mainlistViewModelList[index]
    }
    
    func appendList() {
        
    }
}
