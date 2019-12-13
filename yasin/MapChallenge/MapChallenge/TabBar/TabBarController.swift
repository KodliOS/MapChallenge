//
//  TabBarController.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 7.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        
        viewControllers = makeControllers(from: TabBarPresent.presents())
    }
    
    private func setupAppearance() {
        tabBar.barTintColor = .black
        tabBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
    
    private func makeControllers(from presents: [Presentable]) -> [UIViewController] {
        var controllers = [UIViewController]()
        presents.forEach { present in
            let viewController = present.controller
            viewController.title = present.title
            viewController.view = present.view
            viewController.view.backgroundColor = present.backgroundColor
            
            if let present = present as? TabBarPresent {
                viewController.tabBarItem = present.tabBarItem
            }
            controllers.append(viewController)
        }
        return controllers
    }
}
