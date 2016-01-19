//
//  ItemsViewController.swift
//  ToDoList
//
//  Created by 安正超 on 16/1/19.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController, AddItemDelegate {
    var items: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ToDo List"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addItem:")
        
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "item")
        
        loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItem(sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("AddItemViewController") as! AddItemViewController
        
        vc.delegate = self
        
        presentViewController(vc, animated: true, completion: nil)
    }
    
    private func loadItems() {
        if let filePath = pathForItems() where NSFileManager.defaultManager().fileExistsAtPath(filePath) {
            if let archievedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? [Item]{
                items = archievedItems
            }
        }
    }
    
    private func saveItems() {
        if let filePath = pathForItems() {
            NSKeyedArchiver.archiveRootObject(items, toFile: filePath)
        }
    }
    
    func pathForItems() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        if let documents = paths.first, let documentsUrl = NSURL(string: documents) {
            return documentsUrl.URLByAppendingPathComponent("items.plist").path
        }
        
        return nil
    }
    
    func controller(controller: AddItemViewController, didSaveItemWithTitle title: String) {
        let item = Item(title: title)
        
        items.append(item)
        
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: items.count - 1, inSection: 0)], withRowAnimation: .None)
        
        saveItems()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("item", forIndexPath: indexPath)

        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "提示", message: "完成该项目?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let confirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { action in
            self.items.removeAtIndex(indexPath.row)
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            self.saveItems()
            
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        })

        
        let cancel = UIAlertAction(title: "没有", style: UIAlertActionStyle.Cancel, handler: { action in
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        presentViewController(alert, animated: true, completion: nil)
    }
}
