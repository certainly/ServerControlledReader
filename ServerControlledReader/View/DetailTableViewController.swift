//
//  DetailTableViewController.swift
//  ServerControlledReader
//
//  Created by certainly on 2017/9/17.
//  Copyright © 2017年 certainly. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var parentId: String!
    
    let detailListViewModelController = DetailListViewModelController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailListViewModelController.retrieveDetailList(cid: parentId,  { [unowned self] in
            print("reload...")
            self.tableView.reloadData()
            if self.detailListViewModelController.needRefresh {
                print("needRefresh!")
                self.refresh()
            }
            }, failure: nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return detailListViewModelController.itemsCount
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailListCell", for: indexPath) as? DetailListTableViewCell
        guard let itemCell = cell else { return UITableViewCell() }
        itemCell.textLabel?.numberOfLines=0
        itemCell.cellModel = detailListViewModelController.viewModel(at: indexPath.row)
        return itemCell
    }

    private func refresh() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        detailListViewModelController.refreshDetailList(cid: parentId, { [unowned self] in
            print("refresh detail...")
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.tableView.reloadData()
            }, failure: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
