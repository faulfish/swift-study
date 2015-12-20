//
//  Avatar.swift
//  GitHubRepos
//
//  Created by 安正超 on 15/12/10.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

final class Avatar {
    
    let url: String?
    var image: UIImage?
    
    init(url: String) {
        self.url = url
    }
    
    func loadImage(completeHandler: (image: UIImage?) -> ()){
        Alamofire.request(.GET, self.url!).responseData({ (response: Response<NSData, NSError>) in
            if response.result.isSuccess {
                self.image = UIImage(data: response.result.value!)
                completeHandler(image: self.image)
            }
        })
    }
}