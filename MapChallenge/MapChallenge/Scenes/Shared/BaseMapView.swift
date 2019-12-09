//
//  BaseMapView.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 7.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import MapKit

enum MapType {
    case `default`
    case google
    case yandex
    
    var map: Mapable.Type {
        switch self {
        case .default:
            return DefaultMap.self
        case .google:
            return GoogleMap.self
        case .yandex:
            return YandexMap.self
        }
    }
}

class BaseMapView<Map: Mapable>: UIView, CLLocationManagerDelegate {
    
    private var mapType: MapType
    var mapView: Mapable?
    
    private var locationManager = CLLocationManager()
    private weak var viewController: UIViewController?
    
    private var safeArea: UILayoutGuide!
    private var layout = Layout()
    
    private var region: MKCoordinateRegion?
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Failed to load map"
        label.textColor = UIColor.white
        label.sizeToFit()
        label.center = self.center
        return label
    }()
    
    init(for viewController: UIViewController, map mapType: MapType) {
        self.mapType = mapType
        self.viewController = viewController
        safeArea = viewController.view.layoutMarginsGuide
        super.init(frame: viewController.view.frame)
        setupLocationManager()
        setupLabel()
        setupMap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self // actually don't needed for this project
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
            
            let latitude = locationManager.location?.coordinate.latitude
            let longitude = locationManager.location?.coordinate.longitude
            guard latitude != nil && longitude != nil else { return }
            
            let center = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        } else {
            // show error
            print("--> ERROR: Location service disabled")
            showSimpleAlert(viewController, title: "Permission Error", message: "Can't get your location, Please enable your location service")
        }
    }
    
    private func setupLabel() {
        addSubview(label)
    }
    
    private func setupMap() {
        switch mapType {
        case .default:
            mapView = DefaultMap(locationManager, region: region, frame: bounds)
            makeDefaultMap(handler: nil)
        case .google:
            makeGoogleMap()
        case .yandex:
            makeYandexMap()
        }
    }
    
    private func makeDefaultMap(handler: ((MKMapView) -> Void)? ) {
        guard let mapView = mapView,
            let map = mapView.mapView as? MKMapView else { return }
        self.addSubview(mapView)
        _ = handler != nil ? handler!(map) : nil
        checkAuthorizationStatus(map: mapView)
        makeDefaultMapConstraints(map: mapView)
    }
    
    private func makeGoogleMap() {
        print("google")
    }
    
    private func makeYandexMap() {
        print("yandex")
    }
    
    
    private func checkAuthorizationStatus(map mapView: Mapable) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            print("--> authorizedWhenInUse")
        case .denied:
            print("--> denied")
            break
        case .notDetermined:
            print("--> notDetermined")
        case .restricted:
            print("--> restricted")
            break
        case .authorizedAlways:
            print("--> authorizedAlways")
            break
        @unknown default:
            fatalError()
        }
    }
    
    private func makeDefaultMapConstraints(map: Mapable) {
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
