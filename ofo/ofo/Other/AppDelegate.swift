//
//  AppDelegate.swift
//  ofo
//
//  Created by 马异峰 on 2017/10/6.
//  Copyright © 2017年 Yifeng. All rights reserved.
//

import UIKit
import AVOSCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AMapServices.shared().apiKey = "3b883f9c7a3f7e01b141039ba88dfad6"
        AMapServices.shared().enableHTTPS = true
        AVOSCloud.setApplicationId("ks4lptjNd21eBGsaFy37pkVh-gzGzoHsz", clientKey: "UPSMlLETCRm4uXbFJUEnOsgS")
        
        return true
    }


}

