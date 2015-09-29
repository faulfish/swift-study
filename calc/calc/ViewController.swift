//
//  ViewController.swift
//  calc
//
//  Created by 安正超 on 15/9/29.
//  Copyright © 2015年 安正超. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let operations = ["+","-", "×", "÷", "."]   // 操作符列表
    
    @IBOutlet weak var baseButton: UIButton!    // 基础按钮：7
    @IBOutlet weak var display: UILabel!        // 显示屏
    
    // 点击按钮事件
    @IBAction func addItem(sender: UIButton) {
        let label = sender.currentTitle!
        
        if !itemCanBeInsert(label) { return }
        
        appendItem(label)
    }
    
    // 往显示屏写入字符
    func appendItem(item: String) -> Void {
        if display.text?.characters.count > 0 && display.text != "0" {
            display.text?.appendContentsOf(item)
        } else {
            display.text = item
        }
    }
    
    // 清空
    @IBAction func reset() {
        display.text = "0"
    }
    
    // 计算结果
    @IBAction func calculate() {
    }
    
    // 检查是否当前允许插入该字符
    func itemCanBeInsert(item: String) -> Bool {
        let suffix = display.text?.substringFromIndex((display.text?.endIndex.predecessor())!)
        
        if suffix == nil {return true}
        
        if operations.contains(suffix!) && operations.contains(item){ return false }
        
        if suffix == "0" && item == "÷" { return false }
        
        return true
    }
    
    // 屏幕方向的改变
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.sharedApplication().statusBarOrientation
            
            switch orient {
            case .Portrait:
                print("Portrait")
                // 切换到竖屏
            default:
                print("Anything But Portrait")
                // 切换到横屏
            }
            
            }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                print("rotation completed")
        })
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
}

