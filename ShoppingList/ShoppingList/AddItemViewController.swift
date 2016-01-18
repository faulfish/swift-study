//
//  AddItemViewController.swift
//  ShoppingList
//
//  Created by 安正超 on 16/1/18.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate {
    func controller(controller: AddItemViewController, didSaveItemWithName name: String, andPrice price: Float)
}

class AddItemViewController: UIViewController {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    
    var delegate: AddItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        if let name = nameTextField.text, let priceAsString = priceTextField.text, let price = Float(priceAsString) {
            // Notify Delegate
            delegate?.controller(self, didSaveItemWithName: name, andPrice: price)
            
            // Dismiss View Controller
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
