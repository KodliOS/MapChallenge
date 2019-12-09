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

protocol MapView: UIView { }

extension MKMapView: MapView { }
extension GMSMapView: MapView { }

protocol Mapable: UIView {
    var mapView: MapView? { get set }
    func setupMap()
}

protocol GoogleMapContracts: Mapable, CLLocationManagerDelegate { }
protocol DefaultMapContracts: Mapable, CLLocationManagerDelegate { }
protocol YandexMapContracts: Mapable, CLLocationManagerDelegate { }
protocol MapProviderContracts: DefaultMapContracts, GoogleMapContracts, YandexMapContracts { }

protocol MapProviderDelegate: class {
    func updateGoogleMapPin(handler: (GMSMarker) -> Void)
}
