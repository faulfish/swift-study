//
//  ViewController.swift
//  NoStoryboard
//
//  Created by 安正超 on 15/12/17.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.whiteColor()
        let myView: UIView = UIView(frame: CGRectMake(0, 20, window.frame.width, 200))
        myView.backgroundColor = UIColor.blackColor()
        self.view.addSubview(myView)
        
        let myLabel = UILabel(frame: CGRectMake(50, 100, 180, 50))
        myLabel.text = "Hello!"
        myLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(myLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

