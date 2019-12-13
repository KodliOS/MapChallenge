//
//  AppDelegate.swift
//  MapChallenge
//
//  Created by Oguz on 7.12.2019.
//  Copyright © 2019 Oguz. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyAy0E5roU9ROl7H0KDngqofbE-xuKafRro")
        return true
        
    }


}

