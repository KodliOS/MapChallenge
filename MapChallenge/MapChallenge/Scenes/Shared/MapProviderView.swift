//
//  MapProviderView.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 9.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import MapKit.MKMapView
import GoogleMaps
import GooglePlaces

class MapProviderView:UIView {
    var map: MapType
    var mapView: MapView?
    var layout = Layout()
    var marker: GMSMarker?
    
    var locationManager: CLLocationManager!
    var region: MKCoordinateRegion?
    
    init(_ locationManager:CLLocationManager, region: MKCoordinateRegion?, map: MapType, frame: CGRect) {
        self.locationManager = locationManager
        self.region = region
        self.map = map
        super.init(frame: frame)
        
        setupMap()
        self.addSubview(mapView!)
        makeDefaultMapConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeDefaultMapConstraints() {
        guard let mapView = mapView else { return }
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: layout.mapMargins.left).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -layout.mapMargins.bottom).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -layout.mapMargins.right).isActive = true
        mapView.topAnchor.constraint(equalTo: self.topAnchor, constant: layout.mapMargins.top).isActive = true
    }
    
    struct Layout {
        var mapMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var regionRadius: Double = 1000
    }
}

extension MapProviderView: MapProviderContracts {
    func setupMap() {
        if CLLocationManager.locationServicesEnabled() {
            mapView = MKMapView()
            let location = locationManager.location
            let latitude = location?.coordinate.latitude
            let longitude = location?.coordinate.longitude
            
            switch map {
            case .default:
                mapView = MKMapView()
                guard let mapView = mapView as? MKMapView else { return }
                mapView.mapType = MKMapType.standard
                mapView.isZoomEnabled = true
                mapView.isScrollEnabled = true
                mapView.showsUserLocation = true
                if let region = region {
                    mapView.setRegion(region, animated: true)
                }
            case .google:
                let camera = GMSCameraPosition.camera(withLatitude: latitude!, longitude: longitude!, zoom: 17.0)
                mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                guard let mapView = mapView as? GMSMapView else { return }
                
                mapView.settings.myLocationButton = true
                marker = GMSMarker()
                guard let marker = marker else { return }
                marker.position = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
                marker.title = "Your Location"
                marker.map = mapView
            case .yandex:
                print("yandex")
            }
        }
    }
}

extension MapProviderView: MapProviderDelegate {
    func updateGoogleMapPin(handler: (GMSMarker) -> Void) {
        guard let marker = marker else { return }
        handler(marker)
    }
}

