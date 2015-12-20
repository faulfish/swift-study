//
//  ViewController.swift
//  Alert
//
//  Created by 安正超 on 15/10/23.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
    }
    
    
    @IBAction func eatOrNot(sender: AnyObject) {
        let message = UIAlertView(title: "Hi",
        message: "我只吃电，不吃饭",
        delegate: nil, cancelButtonTitle: nil,
        otherButtonTitles: "好的")
        
        message.show()
    }
}

