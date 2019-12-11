//
//  Mapable.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 9.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import MapKit.MKMapView

protocol Mapable: UIView {
    var map: MapViewContract? { get set }
    func setupMap()
}

protocol GoogleMapContracts: Mapable, CLLocationManagerDelegate { }
protocol DefaultMapContracts: Mapable, CLLocationManagerDelegate { }
protocol YandexMapContracts: Mapable, CLLocationManagerDelegate { }

protocol MapProviderContracts: DefaultMapContracts, GoogleMapContracts, YandexMapContracts { }
