//
//  TabBarPresent.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 7.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class TabBarPresent: Presentable {
    var controller: UIViewController
    var view: UIView?
    var title: String
    var backgroundColor: UIColor
    let tabBarItem: UITabBarItem
    
    internal init(controller: UIViewController, view: UIView?, title: String, backgroundColor: UIColor, tabBarItem: UITabBarItem) {
        self.controller = controller
        self.view = view
        self.title = title
        self.backgroundColor = backgroundColor
        self.tabBarItem = tabBarItem
    }
    
    static func presents() -> [TabBarPresent] {
        return [
            TabBarPresent(
                controller: MapController(),
                view: MapView(map: .default, frame: .zero),
                title: "Default",
                backgroundColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),
                tabBarItem: UITabBarItem(title: "Default Map", image: UIImage(named: "map"), tag: 0)
            ),
            TabBarPresent(
                controller: MapController(),
                view: MapView(map: .google, frame: .zero),
                title: "Google",
                backgroundColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
                tabBarItem: UITabBarItem(title: "Google Map", image: UIImage(named: "map"), tag: 1)
            ),
            TabBarPresent(
                controller: MapController(),
                view: MapView(map: .yandex, frame: .zero),
                title: "Yandex",
                backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                tabBarItem: UITabBarItem(title: "Yandex Map", image: UIImage(named: "map"), tag: 2)
            ),
            TabBarPresent(
                controller: SettingsController(),
                view: SettingsView(),
                title: "Settings",
                backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                tabBarItem: UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 3)
            )
        ]
    }
}
