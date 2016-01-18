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
    
    var book:[String: String]?
    
    lazy var bookCoverImage: UIImage? = {
        var image: UIImage?
        
        if self.book == nil {
            // Initialize Buffer
            var buffer = [AnyObject]()
            
            let filePath = NSBundle.mainBundle().pathForResource("Books", ofType: "plist")
            
            if let path = filePath {
                let authors = NSArray(contentsOfFile: path) as! [AnyObject]
                
                for author in authors {
                    if let books = author["Books"] as? [AnyObject] {
                        buffer += books
                    }
                }
            }
            
            if buffer.count > 0 {
                let random = Int(arc4random()) % buffer.count
                
                if let book = buffer[random] as? [String: String] {
                    self.book = book
                }
            }
        }
        
        if let book = self.book, let fileName = book["Cover"] {
            image = UIImage(named: fileName)
        }
        
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let book = book, title = book["Title"] {
            self.title = title
        }
        
        if let bookCoverImage = bookCoverImage {
            bookCoverView.image = bookCoverImage
            bookCoverView.contentMode = .ScaleAspectFit
        }
    }

    
    @IBAction func backToList() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
