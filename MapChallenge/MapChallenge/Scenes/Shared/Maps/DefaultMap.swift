//
//  DefaultMap.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 9.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import MapKit.MKMapView

class DefaultMap:UIView, DefaultMapConvertible {
    var mapView: MapView? = MKMapView()
    var layout = Layout()
    
    var locationManager: CLLocationManager!
    var region: MKCoordinateRegion?
    
    init(_ locationManager:CLLocationManager, region: MKCoordinateRegion?, frame: CGRect) {
        self.locationManager = locationManager
        self.region = region
        super.init(frame: frame)
        setupMap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMap() {
        if CLLocationManager.locationServicesEnabled() {
            guard let mapView = mapView as? MKMapView else { return }
            mapView.mapType = MKMapType.standard
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true
            mapView.showsUserLocation = true
            
            if let region = region {
                mapView.setRegion(region, animated: true)
            }
            
            self.addSubview(mapView)
            makeDefaultMapConstraints(map: mapView)
        } else {
            // show error
            print("--> ERROR: Location service disabled")
        }
    }
    
    private func makeDefaultMapConstraints(map: MKMapView) {
        map.translatesAutoresizingMaskIntoConstraints = false
        map.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: layout.mapMargins.left).isActive = true
        map.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -layout.mapMargins.bottom).isActive = true
        map.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -layout.mapMargins.right).isActive = true
        map.topAnchor.constraint(equalTo: self.topAnchor, constant: layout.mapMargins.top).isActive = true
    }
    
    struct Layout {
        var mapMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var regionRadius: Double = 1000
    }
}
