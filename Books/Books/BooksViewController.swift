//
//  BooksViewController.swift
//  Books
//
//  Created by 安正超 on 16/1/16.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import UIKit

class BooksViewController: UITableViewController {
    
    let cellId = "book"
    let SegueBookCoverViewController = "BookCoverViewController"
    
    var author: [String: AnyObject]!
    
    var books: [AnyObject] {
        if let books = author["Books"] as? [AnyObject] {
            return books
        }
        
        return [AnyObject]()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = author["Author"] as? String {
            title = name
        }

        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)

        if let book = books[indexPath.row] as? [String: String], let title = book["Title"] {
            cell.textLabel?.text = title
        }

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(SegueBookCoverViewController, sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueBookCoverViewController {
            if let indexPath = tableView.indexPathForSelectedRow, let book = books[indexPath.row] as? [String: String] {
                let destinationViewController = segue.destinationViewController as! BookCoverViewController
                
                destinationViewController.book = book
            }
        }
    }

}
