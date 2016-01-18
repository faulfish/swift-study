//
//  ListViewController.swift
//  ShoppingList
//
//  Created by 安正超 on 16/1/18.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, AddItemViewControllerDelegate, EditItemViewControllerDelegate {
    
    var cellId = "item"
    var items = [Item]()
    
    var selection: Item?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
        
        // Create Add Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addItem:")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editItems:")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadItems() {
        if let filePath = pathForItems() where NSFileManager.defaultManager().fileExistsAtPath(filePath) {
            if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? [Item] {
                items = archivedItems
            }
        }
    }
    
    func addItem(sender: UIBarButtonItem) {
        performSegueWithIdentifier("AddItemViewController", sender: self)
    }
    
    func editItems(sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.editing, animated: true)
    }
    
    private func saveItems() {
        if let filePath = pathForItems() {
            NSKeyedArchiver.archiveRootObject(items, toFile: filePath)
            NSNotificationCenter.defaultCenter().postNotificationName("ShoppingListDidChangeNotification", object: self)
        }
    }
    
    private func pathForItems() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        if let documents = paths.first, let documentsURL = NSURL(string: documents) {
            return documentsURL.URLByAppendingPathComponent("items.plist").path
        }
        
        return nil
    }
    
    func controller(controller: AddItemViewController, didSaveItemWithName name: String, andPrice price: Float) {
        let item = Item(name: name, price: price)
        
        items.append(item)
        
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: (items.count - 1), inSection: 0)], withRowAnimation: .None)
        
        saveItems()
    }
    
    func controller(controller: EditItemViewController, didUpdateItem item: Item) {
        if let index = items.indexOf(item) {
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Fade)
        }
        
        saveItems()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddItemViewController" {
            if let navigationController = segue.destinationViewController as? UINavigationController,
                let addItemViewController = navigationController.viewControllers.first as? AddItemViewController {
                addItemViewController.delegate = self
            }
        } else if segue.identifier == "EditItemViewController" {
            if let editItemViewController = segue.destinationViewController as? EditItemViewController, let item = selection {
                editItemViewController.delegate = self
                editItemViewController.item = item
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)

        // Fetch Item
        let item = items[indexPath.row]
        
        // Configure Table View Cell
        cell.textLabel?.text = item.name
        
        cell.accessoryType = .DetailDisclosureButton
        
        if item.inShoppingList {
            cell.imageView?.image = UIImage(named: "checkmark")
        } else {
            cell.imageView?.image = nil
        }

        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            items.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            saveItems()
        }   
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let item = items[indexPath.row]
        
        item.inShoppingList = !item.inShoppingList
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if item.inShoppingList {
            cell?.imageView?.image = UIImage(named: "checkmark")
        } else {
            cell?.imageView?.image = nil
        }
        
        saveItems()
    }

    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let item = items[indexPath.row]
        
        selection = item
        
        performSegueWithIdentifier("EditItemViewController", sender: self)
    }

}
