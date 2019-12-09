//
//  AppDelegate.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 7.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import GoogleMaps.GMSServices
import GooglePlaces.GMSPlacesClient

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        defer {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = TabBarController()
            window?.makeKeyAndVisible()
        }
        accessGoogleMaps()
        return true
    }
    
    func accessGoogleMaps() {
        GMSPlacesClient.provideAPIKey("AIzaSyCKuDgr3TMsuiW_XcKC5OWo5Mt8qrFCJnw")
        GMSServices.provideAPIKey("AIzaSyCKuDgr3TMsuiW_XcKC5OWo5Mt8qrFCJnw")
    }
}
