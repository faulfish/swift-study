//
//  AppDelegate.swift
//  DataPersistence
//
//  Created by 安正超 on 16/1/17.
//  Copyright © 2016年 overtrue. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let directories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        if let documents = directories.first {
            if let urlDocuments = NSURL(string: documents) {
                let urlFruits = urlDocuments.URLByAppendingPathComponent("fruits.plist")
                let urlDictionary = urlDocuments.URLByAppendingPathComponent("dictionary.plist")
                
                let fruits = ["Apple", "Mango", "Pineapple"] as NSArray
                let dictionary = ["anArray": fruits, "aNumber":12345] as NSDictionary
                
                fruits.writeToFile(urlFruits.path!, atomically: true)
                dictionary.writeToFile(urlDictionary.path!, atomically: true)
                
                let loadedFruits = NSArray(contentsOfURL: urlFruits)
                if let fruits = loadedFruits {
                    print(fruits)
                }
                
                let loadedDictionary = NSDictionary(contentsOfURL: urlDictionary)

                if let dictionary = loadedDictionary {
                    print(dictionary)
                }
            }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

