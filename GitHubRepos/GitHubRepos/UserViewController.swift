//
//  UserViewController.swift
//  GitHubRepos
//
//  Created by 安正超 on 15/12/10.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import UIKit
import Alamofire



class UserViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var followersNumLabel: UILabel!
    @IBOutlet weak var starredNumLabel: UILabel!
    @IBOutlet weak var followingNumLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserFromGitHub()
    }
    
    func loadUserFromGitHub() {
        let cache = NSCache()
        
        if let user = cache.objectForKey("user") as? User {
            self.showUser(user)
        } else {
            Alamofire.request(GitHubRequest.User("overtrue"))
                .responseObject { (response: Response<User, NSError>) in
                    if let user = response.result.value {
                        self.showUser(user)
                        cache.setObject(user, forKey: "user")
                    }
            }
        }
        
    }
    
    func showUser(user: User) {
        self.usernameLabel.text = user.username
        self.userLocationLabel.text = user.location
        
        self.followersNumLabel.text = "\(user.followers!)"
        self.starredNumLabel.text   = "0"
        self.followingNumLabel.text = "\(user.following!)"
        
        if user.avatar != nil {
            var avatar = Image(url: user.avatar!)
            avatar.load({ image in
                self.avatarImageView.image = image
            })
        }
    }
}
