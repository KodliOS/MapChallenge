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
    var title: String
    var backgroundColor: UIColor
    let tabBarItem: UITabBarItem
    
    internal init(controller: UIViewController, title: String, backgroundColor: UIColor, tabBarItem: UITabBarItem) {
        self.controller = controller
        self.title = title
        self.backgroundColor = backgroundColor
        self.tabBarItem = tabBarItem
    }
    
    static func presents() -> [TabBarPresent] {
        return [
            TabBarPresent(
                controller: MapController(map: .default),
                title: "Default",
                backgroundColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),
                tabBarItem: UITabBarItem(title: "Default Map", image: UIImage(named: "map"), tag: 0)
            ),
            TabBarPresent(
                controller: MapController(map: .google),
                title: "Google",
                backgroundColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
                tabBarItem: UITabBarItem(title: "Google Map", image: UIImage(named: "map"), tag: 1)
            ),
            TabBarPresent(
                controller: MapController(map: .yandex),
                title: "Yandex",
                backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                tabBarItem: UITabBarItem(title: "Yandex Map", image: UIImage(named: "map"), tag: 2)
            ),
            TabBarPresent(
                controller: SettingsController(),
                title: "Settings",
                backgroundColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),
                tabBarItem: UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 3)
            )
        ]
    }
}
