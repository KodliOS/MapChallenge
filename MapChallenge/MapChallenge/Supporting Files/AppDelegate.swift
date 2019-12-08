//
//  AppDelegate.swift
//  MapChallenge
//
//  Created by Berk Batuhan ŞAKAR on 7.12.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import UIKit
import GoogleMaps
import YandexMapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyDshkRlRnp2tH_U1i3QML0GvPsfQzRkYLw")
        YMKMapKit.setApiKey("312c437d-d817-4e9b-8c71-dc594f5233ae")
        return true
    }

}

