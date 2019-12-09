//
//  Mapable.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 9.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import MapKit.MKMapView

protocol MapView: UIView { }

protocol Mapable: UIView {
    var mapView: MapView? { get set }
    func setupMap()
}

protocol DefaultMapConvertible: Mapable, CLLocationManagerDelegate {

}

protocol GoogleMapConvertible: Mapable {
    
}

protocol YandexMapConvertible: Mapable {
    
}

extension MKMapView: MapView {}


// TODO: temporary mock model
class MockMap:UIView, Mapable {
    var mapView: MapView? = MKMapView()
    
    var type: MapType
    
    init(frame: CGRect, type: MapType) {
        self.type = type
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMap() {
        
    }
}
