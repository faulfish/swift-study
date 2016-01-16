//
//  AuthorsViewController.swift
//  Books
//
//  Created by 安正超 on 16/1/16.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import UIKit

class AuthorsViewController: UITableViewController {
    
    let cellId = "author"
    let SegueBooksViewController = "BooksViewController"
    
    var authors: [AnyObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Authors"
        
        let filePath = NSBundle.mainBundle().pathForResource("Books", ofType: "plist")
        
        if let path = filePath {
            authors = NSArray(contentsOfFile: path) as! [AnyObject]
        }

        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authors.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)

        if let author = authors[indexPath.row] as? [String: AnyObject], let name = author["Author"] as? String {
            cell.textLabel?.text = name
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(SegueBooksViewController, sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueBooksViewController {
            if let indexPath = tableView.indexPathForSelectedRow, let author = authors[indexPath.row] as? [String: AnyObject] {
                let destinationViewController = segue.destinationViewController as! BooksViewController
                destinationViewController.author = author
            }
        }
    }
}
