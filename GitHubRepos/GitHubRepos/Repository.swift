//
//  Repository.swift
//  GitHubRepos
//
//  Created by 安正超 on 15/12/10.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import Foundation

final class Repository:ObjectSerializable, CollectionSerializable {
    
    let name: String
    let url: String
    
    required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.name = representation.valueForKeyPath("name") as! String
        self.url = representation.valueForKeyPath("html_url") as! String
    }
    
    static func collection(response: NSHTTPURLResponse, representation: AnyObject) -> [Repository] {
        var repos: [Repository] = []
        
        if let representation = representation as? [[String:AnyObject]] {
            for repoRepresentation in representation {
                if let repo = Repository(response: response, representation: repoRepresentation) {
                    repos.append(repo)
                }
            }
        }
        
        return repos
    }
}