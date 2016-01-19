//
//  Item.swift
//  ToDoList
//
//  Created by 安正超 on 16/1/19.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding {
    var id: String = NSUUID().UUIDString
    var title: String = ""
    var finished: Bool = false
    
    init(title: String, finished: Bool = false) {
        self.title = title
        self.finished = finished
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let id = aDecoder.decodeObjectForKey("id") as? String {
            self.id = id
        }
        
        
        if let title = aDecoder.decodeObjectForKey("title") as? String {
            self.title = title
        }
        
        self.finished = aDecoder.decodeBoolForKey("finished")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeBool(finished, forKey: "finished")
    }
}