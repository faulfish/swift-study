//
//  AddItemViewController.swift
//  ToDoList
//
//  Created by 安正超 on 16/1/19.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import UIKit

protocol AddItemDelegate {
    func controller(controller: AddItemViewController, didSaveItemWithTitle title: String)
}

class AddItemViewController: UIViewController {
    
    var delegate: AddItemDelegate?
    
    @IBOutlet var titleField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "添加条目"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save() {
        if let title = titleField.text where title.characters.count > 0 {
            delegate?.controller(self, didSaveItemWithTitle: title)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
