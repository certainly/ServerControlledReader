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
//            dataManager.reset()
//            dataManager.makeFakeData()

            let list = try dataManager.retrieveMainList()
            
//            if list.count == 0 {
//                print("empty list!")
//                fetchFromServer(success)
//                return
//            }
            mainlistViewModelList.removeAll()
            mainlistViewModelList = list.map(){MainListViewModel(withItem: $0 ) }
            
            
            
            success?()
            print("retrieve over")
        } catch {
            print(error)
            failure?()
        }
    }
    
    func refreshMainLists(_ success: (() -> Void)?, failure: ( () -> Void)?)  {
        do{
            fetchFromServer(update: false, success)
        } catch {
            print(error)
            failure?()
        }
    }
    
    private func fetchFromServer(update: Bool = false,  _ success: (() -> Void)?) {
        NetworkProvider.fetchMainList(update: update) { [unowned self] data in
            print("exe suc")
            self.dataManager.insertDataArray(data)
            DispatchQueue.main.async {
                self.retrieveMainLists(success, failure: nil)
            }
            
        }
    }
    
//    private func  retrieveMainListsStub()   -> [MainListViewModel] {
//        var rz = [MainListViewModel]()
//        let data1 = MainListViewModel(displayText: "testdata111")
//        let data2 = MainListViewModel(displayText: "testdata2222")
//        let data3 = MainListViewModel(displayText: "testdata3")
//        rz.append(data1)
//        rz.append(data2)
//        rz.append(data3)
//        return rz
//    }
    
    func viewModel(at index: Int) -> MainListViewModel {
        return mainlistViewModelList[index]
    }
    
    func getCidAt(_ index: Int) -> String {
        return mainlistViewModelList[index].cid
    }
    
    func appendList() {
        
    }
}
