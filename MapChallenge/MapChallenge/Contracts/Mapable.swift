//
//  Mapable.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 9.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import MapKit.MKMapView
import GoogleMaps
import YandexMapKit

protocol MapView: UIView { }

extension MKMapView: MapView { }
extension GMSMapView: MapView { }
extension YMKMapView: MapView { }

protocol Mapable: UIView {
    var map: MapView? { get set }
    func setupMap()
}

protocol GoogleMapContracts: Mapable, CLLocationManagerDelegate { }
protocol DefaultMapContracts: Mapable, CLLocationManagerDelegate { }
protocol YandexMapContracts: Mapable, CLLocationManagerDelegate { }

protocol MapProviderContracts: DefaultMapContracts, GoogleMapContracts, YandexMapContracts { }
