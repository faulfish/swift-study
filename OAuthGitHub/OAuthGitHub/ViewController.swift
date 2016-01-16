//
//  ViewController.swift
//  OAuthGitHub
//
//  Created by 安正超 on 15/12/20.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import UIKit
import OAuthSwift

class ViewController: UIViewController {

    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let oauthswift = OAuth2Swift(
            consumerKey:    "405be243a18b62d28c36",
            consumerSecret: "8618e4170a8a80399af056625be6ce4a3dd93408",
            authorizeUrl:   "https://github.com/login/oauth/authorize",
            accessTokenUrl: "https://github.com/login/oauth/access_token",
            responseType:   "code"
        )
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "oauthgithub://oauth-callback/github")!,
            scope: "user,repo", state:"github",
            success: { credential, response, parameters in
                print(credential.oauth_token)
                oauthswift.client.request("https://api.github.com/users/overtrue",  method: .GET,
                    headers: ["Accept":"application/vnd.github.v3+json"],
                    success: { (data: NSData, response) in
                        if let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) {
                            self.nameLabel.text = json.valueForKey("name") as? String
                            self.usernameLabel.text = json.valueForKey("username") as? String
                            self.emailLabel.text = json.valueForKey("email") as? String
                            self.locationLabel.text = json.valueForKey("location") as? String
                            
                            if let avatarUrl = json.valueForKey("avatar_url") as? String {
                                oauthswift.client.request(avatarUrl, method: .GET, success: { (data: NSData, response) in
                                    self.avatarView.image = UIImage(data: data)
                                    print("avatar loaded")
                                }, failure: nil)
                            }

                        }
                    }, failure: nil)
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

