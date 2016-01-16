//
//  ViewController.swift
//  TableViewStudy
//
//  Created by 安正超 on 16/1/16.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "fruitCell"
    
    var fruits: [String] = []
    
    var alphabetizedFruits = [String: [String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fruits = ["Apple", "Pineapple", "Orange", "Blackberry", "Banana", "Pear", "Kiwi", "Strawberry", "Mango", "Walnut", "Apricot", "Tomato", "Almond", "Date", "Melon", "Water Melon", "Lemon", "Coconut", "Fig", "Passionfruit", "Star Fruit", "Clementin", "Citron", "Cherry", "Cranberry"]
        
        // Alphabetize Fruits
        alphabetizedFruits = alphabetizeArray(fruits)
    }
    
    // MARK: -
    // MARK: Helper Methods
    private func alphabetizeArray(array: [String]) -> [String: [String]] {
        var result = [String: [String]]()
        
        for item in array {
            let index = item.startIndex.advancedBy(1)
            let firstLetter = item.substringToIndex(index).uppercaseString
            
            if result[firstLetter] != nil {
                result[firstLetter]!.append(item)
            } else {
                result[firstLetter] = [item]
            }
        }
        
        for (key, value) in result {
            result[key] = value.sort({ (a, b) -> Bool in
                a.lowercaseString < b.lowercaseString
            })
        }
        
        return result
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return alphabetizedFruits.keys.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = alphabetizedFruits.keys
        
        let sortKeys = keys.sort {
            return $0.lowercaseString < $1.lowercaseString
        }
        
        let key = sortKeys[section]
        
        if let fruits = alphabetizedFruits[key] {
            return fruits.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let keys = alphabetizedFruits.keys.sort {
            return $0.lowercaseString < $1.lowercaseString
        }
        
        return keys[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        let keys = alphabetizedFruits.keys.sort {
            return $0.lowercaseString < $1.lowercaseString
        }
        
        let key = keys[indexPath.section]
        
        if let fruits = alphabetizedFruits[key] {
            let fruit = fruits[indexPath.row]

            cell.textLabel?.text = fruit
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let keys = alphabetizedFruits.keys.sort {
            return $0.lowercaseString < $1.lowercaseString
        }
        
        let key = keys[indexPath.section]
        
        if let fruits = alphabetizedFruits[key] {
            let fruit = fruits[indexPath.row]
            
            print(fruit)
        }
    }
}

