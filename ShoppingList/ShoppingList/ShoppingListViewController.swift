
//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by 安正超 on 16/1/18.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import UIKit

class ShoppingListViewController: UITableViewController {
    let CellIdentifier = "shoppingList"
    
    var items = [Item]() {
        didSet {
            buildShoppingList()
        }
    }
    var shoppingList = [Item]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Title
        title = "Shopping List"
        
        // Load Items
        loadItems()
        
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: CellIdentifier)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateShoppingList:", name: "ShoppingListDidChangeNotification", object: nil)
    }
    
    
    // MARK: -
    // MARK: Helper Methods
    func buildShoppingList() {
        shoppingList = items.filter({ (item) -> Bool in
            return item.inShoppingList
        })
    }
    
    func updateShoppingList(notification: NSNotification) {
        print("updated")
        loadItems()
    }
    
    private func loadItems() {
        if let filePath = pathForItems() where NSFileManager.defaultManager().fileExistsAtPath(filePath) {
            if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? [Item] {
                items = archivedItems
            }
        }
    }
    
    private func pathForItems() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
            return documentsURL.URLByAppendingPathComponent("items").path
        }
        
        return nil
    }
    
    
    // MARK: -
    // MARK: Table View Data Source Methods
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Dequeue Reusable Cell
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath)
        
        // Fetch Item
        let item = shoppingList[indexPath.row]
        
        // Configure Table View Cell
        cell.textLabel?.text = item.name
        
        return cell
    }
}
