//
//  UIView.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 10.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
