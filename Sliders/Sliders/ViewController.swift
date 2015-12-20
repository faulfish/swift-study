//
//  ViewController.swift
//  Sliders
//
//  Created by 安正超 on 15/11/22.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SliderChanged(sender: UISlider) {
        label.text = "\(lroundf(sender.value))"
    }

    @IBAction func toggle(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            label.text = "First"
        } else {
            label.text = "Second"
        }
    }
}

