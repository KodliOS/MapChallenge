//
//  Presentable.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 7.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

protocol Presentable: class {
    var controller: UIViewController { get set }
    var title: String { get set }
    var backgroundColor: UIColor { get set }
}
