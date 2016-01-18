//
//  Item.swift
//  ShoppingList
//
//  Created by 安正超 on 16/1/18.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    var uuid: String = NSUUID().UUIDString
    var name: String = ""
    var price: Float = 0.0
    var inShoppingList = false
    
    init(name: String, price: Float) {
        super.init()
        
        self.name = name
        self.price = price
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        if let uuid = aDecoder.decodeObjectForKey("uuid") as? String {
            self.uuid = uuid
        }
        
        if let name = aDecoder.decodeObjectForKey("name") as? String {
            self.name = name
        }
        
        price = aDecoder.decodeFloatForKey("price")
        inShoppingList = aDecoder.decodeBoolForKey("inShoppingList")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(uuid, forKey: "uuid")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeFloat(price, forKey: "price")
        aCoder.encodeBool(inShoppingList, forKey: "inShoppingList")
    }
}
