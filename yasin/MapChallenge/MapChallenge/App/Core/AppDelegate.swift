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
import YandexMapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        defer {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = TabBarController()
            window?.makeKeyAndVisible()
        }
        accessGoogleMap()
        accessYandexMap()
        return true
    }
    
    func accessGoogleMap() {
        GMSPlacesClient.provideAPIKey("AIzaSyCKuDgr3TMsuiW_XcKC5OWo5Mt8qrFCJnw")
        GMSServices.provideAPIKey("AIzaSyCKuDgr3TMsuiW_XcKC5OWo5Mt8qrFCJnw")
    }
    func accessYandexMap() {
        YMKMapKit.setApiKey("fdbc4429-ea16-4fea-add1-d063ef82993c")
    }
}
