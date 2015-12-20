//
//  User.swift
//  GitHubRepos
//
//  Created by 安正超 on 15/12/10.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import Foundation

final class User: ObjectSerializable, CollectionSerializable {
    
    let id: UInt
    let username: String
    let name: String
    let avatar: String?
    let location: String?
    let email: String?
    let createdAt: String?
    let followers: Int?
    let following: Int?
    
    var attributes: [AnyObject]?
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.username = response.URL!.lastPathComponent!
        self.name = representation.valueForKeyPath("name") as! String
        self.id = representation.valueForKeyPath("id") as! UInt
        self.avatar = representation.valueForKeyPath("avatar_url") as? String
        self.location = representation.valueForKeyPath("location") as? String
        self.email = representation.valueForKeyPath("email") as? String
        self.createdAt = representation.valueForKeyPath("created_at") as? String
        self.followers = representation.valueForKeyPath("followers") as? Int
        self.following = representation.valueForKeyPath("following") as? Int
        
        self.attributes = representation.attributes
    }
    
    static func collection(response: NSHTTPURLResponse, representation: AnyObject) -> [User] {
        var users: [User] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for userRepresentation in representation {
                if let user = User(response: response, representation: userRepresentation) {
                    users.append(user)
                }
            }
        }
        
        return users
    }

}