//
//  MyCustomAppProxyProvider.swift
//  MAPIDevSugar
//
//  Created by 安正超 on 15/11/19.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import Foundation
import NetworkExtension

class MyCustomAppProxyProvider:NEAppProxyProvider
{
    override func setTunnelNetworkSettings(tunnelNetworkSettings: NETunnelNetworkSettings?, completionHandler: ((NSError?) -> Void)?) {
        print(tunnelNetworkSettings)
    }
    
    override func startProxyWithOptions(options: [String : AnyObject]?, completionHandler: (NSError?) -> Void) {
        print("setup proxy")
        print(options)
    }
}