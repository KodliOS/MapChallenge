//
//  SecondViewController.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 7.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit

class GoogleMapController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        self.view = BaseMapView<MockMap>(for: self, map: .google)
    }
}
