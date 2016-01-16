//
//  BookCoverViewController.swift
//  Books
//
//  Created by 安正超 on 16/1/17.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import UIKit

class BookCoverViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var bookCoverView: UIImageView!
    
    var book:[String: String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let title = book["Title"] {
            self.title = title
        }
        
        if let filename = book["Cover"] {
            bookCoverView.image = UIImage(named: filename)
            bookCoverView.contentMode = .ScaleAspectFit
        }
    }

    
    @IBAction func backToList() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
