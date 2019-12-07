//
//  TabBarController.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 7.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var tabBarPresents: [Presentable] = TabBarPresent.presents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        
        viewControllers = makeControllers(tabBarPresents)
    }
    
    private func setupAppearance() {
        tabBar.barTintColor = .black
    }
    
    private func makeControllers(_ presents: [Presentable]) -> [UIViewController] {
        var controllers = [UIViewController]()
        presents.forEach { present in
            let viewController = present.controller
            viewController.title = present.title
            viewController.view.backgroundColor = present.backgroundColor
            
            if let present = present as? TabBarPresent {
                viewController.tabBarItem = present.tabBarItem
            }
            controllers.append(viewController)
        }
        return controllers
    }
}
