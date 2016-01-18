//
//  EditItemViewController.swift
//  ShoppingList
//
//  Created by 安正超 on 16/1/18.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import UIKit

protocol EditItemViewControllerDelegate {
    func controller(controller: EditItemViewController, didUpdateItem item: Item)
}

class EditItemViewController: UIViewController {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    
    var item: Item!
    
    var delegate: EditItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "save:")
        
        // Populate Text Fields
        nameTextField.text = item.name
        priceTextField.text = "\(item.price)"
    }
    
    func save(sender: UIBarButtonItem) {
        if let name = nameTextField.text, let priceAsString = priceTextField.text, let price = Float(priceAsString) {
            // Update Item
            item.name = name
            item.price = price
            
            // Notify Delegate
            delegate?.controller(self, didUpdateItem: item)
            
            // Pop View Controller
            navigationController?.popViewControllerAnimated(true)
        }
    }
}
