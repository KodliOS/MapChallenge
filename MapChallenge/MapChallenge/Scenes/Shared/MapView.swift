//
//  MapView.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 7.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

enum MapType {
    case `default`
    case google
    case yandex
}

class MapView<Map: Mapable>: UIView, CLLocationManagerDelegate {
    
    private var type: MapType {
        didSet {
            switch type {
            case .default:
                mapView = MKMapView()
            case .google:
                mapView = nil
            case .yandex:
                mapView = nil
            }
        }
    }
    var mapView: Any?
    //    var mapView: Map? // TODO: --
    
    private var locationManager: CLLocationManager?
    private var viewController: UIViewController
    
    private var safeArea: UILayoutGuide!
    private var layout = Layout()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Map view"
        label.sizeToFit()
        label.center = self.center
        return label
    }()
    
    init(for viewController: UIViewController, type: MapType, map mapView: Map? = nil) {
        self.type = type
        self.viewController = viewController
        //        self.mapView = mapView // TODO: --
        safeArea = viewController.view.layoutMarginsGuide
        super.init(frame: viewController.view.frame)
        setupLabel()
        setupMap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        addSubview(label)
        print("->label frame: ", label.frame)
    }
    
    private func setupMap() {
        switch type {
        case .default:
            makeDefaultMap()
        case .google:
            makeGoogleMap()
        case .yandex:
            makeYandexMap()
        }
    }
    
    private func makeDefaultMap(handler: ((_ :MKMapView) -> Void)? = nil) {
        print("default")
        mapView = MKMapView()
        guard let mapView = mapView as? MKMapView else { return }
        if CLLocationManager.locationServicesEnabled() {
            mapView.mapType = MKMapType.standard
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true
            
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.distanceFilter = kCLDistanceFilterNone
            locationManager?.startUpdatingLocation()
            
            self.addSubview(mapView)
            checkAuthorizationStatus(map: mapView)
            makeDefaultMapConstraints(map: mapView)
            
        } else {
            // show error
            print("--> ERROR: Location service disabled")
            let alertController = UIAlertController(title: "Permission Error", message: "Can't get your location, Please enable your location service", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            viewController.present(alertController, animated: true)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            guard let mapView = mapView as? MKMapView else { return }
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func checkAuthorizationStatus(map mapView: MKMapView) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            print("--> authorizedWhenInUse")
            mapView.showsUserLocation = true
        case .denied:
            print("--> denied")
            break
        case .notDetermined:
            print("--> notDetermined")
            locationManager?.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .restricted:
            print("--> restricted")
            break
        case .authorizedAlways:
            print("--> authorizedAlways")
            mapView.showsUserLocation = true
            break
        @unknown default:
            fatalError()
        }
    }
    
    private func makeDefaultMapConstraints(map: MKMapView) {
        map.translatesAutoresizingMaskIntoConstraints = false
        map.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: layout.mapMargins.left).isActive = true
        map.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -layout.mapMargins.bottom).isActive = true
        map.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -layout.mapMargins.right).isActive = true
        map.topAnchor.constraint(equalTo: self.topAnchor, constant: layout.mapMargins.top).isActive = true
    }
    
    private func makeGoogleMap() {
        print("google")
    }
    
    private func makeYandexMap() {
        print("yandex")
    }
    
    struct Layout {
        var mapMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var regionRadius: Double = 1000
    }
}
