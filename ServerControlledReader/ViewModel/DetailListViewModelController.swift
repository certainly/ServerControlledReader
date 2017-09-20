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
    fileprivate var dataManager = MainListLocalDataManager.sharedInstance
    
    var needRefresh: Bool {
        return detailListViewModelList.count == 1 && ( detailListViewModelList[0].source == "V2" || detailListViewModelList[0].kids.characters.count > 0 )
    }
    
    var title: String?
//    var source: String {
//        return detailListViewModelList[0].source
//    }
    
    var itemsCount: Int {
        return detailListViewModelList.count
    }
    
    func viewModel(at index: Int) -> DetailListViewModel {
        return detailListViewModelList[index]
    }
    
    func retrieveDetailList(cid: String, _ success: (() -> Void)?, failure: ( () -> Void)?)  {
        do{
                        try dataManager.test()
            //            dataManager.makeFakeData()
            
            let firstMeta = try  dataManager.retrieveDetailList(cid)
            var list = try dataManager.retrieveDetailCommentsList(cid)
            list.insert(firstMeta, at: 0)
            title =  firstMeta.content
            //            if list.count == 0 {
            //                print("empty list!")
            //                fetchFromServer(success)
            //                return
            //            }

            
            detailListViewModelList.removeAll()
            detailListViewModelList = list.map(){DetailListViewModel(withItem: $0 ) }
            success?()
            print("retrieve over \(list.count)")
        } catch {
            print(error)
            failure?()
        }
    }
    func refreshDetailList(cid: String, _ success: (() -> Void)?, failure: ( () -> Void)?) {
       
        NetworkProvider.fetchDetailList(header :  forgeHeaderForRequest(cid)) { [weak self] data in
            print("exe suc")
            self?.dataManager.updateCommentDataArray(data, withId: cid)
            DispatchQueue.main.async {
                self?.retrieveDetailList(cid: cid, success, failure: nil)
            }
        }
    }
    
    private func forgeHeaderForRequest(_ cid: String) -> [String:String] {
        var rz : [String : String] = [:]
        let kids = detailListViewModelList[0].kids
        if kids.characters.count > 0 {
            rz = ["kids" : kids]
        } else {
            rz = ["cid" : cid ]
        }
        return rz
    }
}
