//
//  BaseMapView.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 7.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

enum MapType {
    case `default`
    case google
    case yandex
}

class BaseMapView: UIView, CLLocationManagerDelegate {
    private var mapType: MapType
    var mapView: Mapable?
    weak var delegate: MapProviderDelegate?
    
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
        super.init(frame: viewController.view.frame)
        self.viewController = viewController
        safeArea = viewController.view.layoutMarginsGuide
        setupLocationManager()
        setupLabel()
        setupMap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMap() {
        mapView = MapProviderView(locationManager, region: region, map: mapType, frame: bounds)
        delegate = mapView as? MapProviderDelegate
        guard let mapView = mapView else { return }
        addSubview(mapView)
        checkAuthorizationStatus()
        
        makeDefaultMapConstraints(map: mapView)
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
            region = MKCoordinateRegion(
                center: center,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        } else {
            showSimpleAlert(
                viewController,
                title: "Permission Error",
                message: "Can't get your location, Please enable your location service"
            )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let map = mapView?.mapView as? GMSMapView else { return }
        let location: CLLocation = locations.last!
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let camera = GMSCameraPosition.camera(
            withLatitude: latitude,
            longitude: longitude,
            zoom: 17
        )
        map.animate(to: camera)
        delegate?.updateGoogleMapPin(handler: { marker in
            marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        })
        
    }
    
    private func setupLabel() {
        addSubview(label)
    }
    
    
    private func checkAuthorizationStatus() {
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
    
    private func makeDefaultMapConstraints(map: Mapable?) {
        guard let map = map else { return }
        map.translatesAutoresizingMaskIntoConstraints = false
        map.leadingAnchor.constraint(equalTo: leadingAnchor, constant: layout.mapMargins.left).isActive = true
        map.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -layout.mapMargins.bottom).isActive = true
        map.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -layout.mapMargins.right).isActive = true
        map.topAnchor.constraint(equalTo: topAnchor, constant: layout.mapMargins.top).isActive = true
    }
    
    struct Layout {
        var mapMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var regionRadius: Double = 1000
    }
}
