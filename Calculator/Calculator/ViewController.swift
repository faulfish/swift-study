//
//  ViewController.swift
//  Calculator
//
//  Created by 安正超 on 15/10/18.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var screen: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushOperation(sender: UIButton) {
        screen.text = sender.currentTitle
    }
}

