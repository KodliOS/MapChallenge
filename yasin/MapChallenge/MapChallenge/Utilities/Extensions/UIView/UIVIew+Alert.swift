//
//  UIVIew+Alert.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 9.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

extension UIView {
    /// shows one action alert
    func showSimpleAlert(
        _ viewController: UIViewController?,
        title: String,
        message: String,
        handler: ((UIAlertAction) -> Void)? = nil
    ) {
        guard let viewController = viewController else { return }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true)
    }
    
    /// shows two customizable actions alert
    func showMultipleActionsAlert(
        _ viewController: UIViewController?,
        title: String,
        message: String,
        actions:((_:UIAlertAction, _:UIAlertAction) -> Void)
    ) {
        guard let viewController = viewController else { return }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let firstAction = UIAlertAction()
        let secondAction = UIAlertAction()
        
        actions(firstAction,secondAction)
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        viewController.present(alertController, animated: true)
    }
}
