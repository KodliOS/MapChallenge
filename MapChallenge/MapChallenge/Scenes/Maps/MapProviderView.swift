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
import YandexMapKit

class MapProviderView:UIView {
    var mapType: MapType
    var map: MapViewContract?
    var layout = Layout()
    var marker: GMSMarker?
    
    var locationManager: CLLocationManager!
    var region: MKCoordinateRegion?
    
    init(_ locationManager:CLLocationManager, region: MKCoordinateRegion?, type: MapType, frame: CGRect, marker: Bool = false) {
        self.locationManager = locationManager
        self.region = region
        self.mapType = type
        super.init(frame: frame)
        
        setupMap()
        makeDefaultMapConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeDefaultMapConstraints() {
        guard let map = map else { return }
        self.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        map.leftAnchor.constraint(equalTo: leftAnchor, constant: layout.mapMargins.left).isActive = true
        map.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -layout.mapMargins.bottom).isActive = true
        map.rightAnchor.constraint(equalTo: rightAnchor, constant: -layout.mapMargins.right).isActive = true
        map.topAnchor.constraint(equalTo: topAnchor, constant: layout.mapMargins.top).isActive = true
    }
    
    struct Layout {
        var mapMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var regionRadius: Double = 1000
    }
}

extension MapProviderView: MapProviderContracts {
    func setupMap() {
        if CLLocationManager.locationServicesEnabled() {
            map = MKMapView()
            let latitude = locationManager.location?.coordinate.latitude
            let longitude = locationManager.location?.coordinate.longitude
            guard latitude != nil && longitude != nil else { return }
            
            switch mapType {
            case .default:
                setupDefaultMap()
            case .google:
                setupGoogleMap(latitude: latitude!, longitude: longitude!)
            case .yandex:
                setupYandexMap(latitude: latitude!, longitude: longitude!)
            }
        }
    }
    
    private func setupDefaultMap() {
        map = MKMapView()
        guard let mapView = map as? MKMapView else { return }
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        if let region = region {
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func setupGoogleMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let camera = GMSCameraPosition.camera(
            withLatitude: latitude,
            longitude: longitude,
            zoom: Float(zoom)
        )
        map = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        guard let mapView = map as? GMSMapView else { return }
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    private func setupYandexMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        map = YMKMapView()
        print("type of map \(type(of: map))")
        guard let mapView = map as? YMKMapView else { return }
        mapView.mapWindow.map.isRotateGesturesEnabled = false
        let userLocationLayer = YMKMapKit.sharedInstance().createUserLocationLayer(with: mapView.mapWindow)
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        mapView.mapWindow.map.move(
            with: YMKCameraPosition.init(
                target: YMKPoint(
                    latitude: latitude,
                    longitude: longitude
                ),
                zoom: Float(zoom),
                azimuth: 0,
                tilt: 0
            ),
            animationType: YMKAnimation(
                type: YMKAnimationType.smooth,
                duration: 5),
            cameraCallback: nil)
    }
}

extension MapProviderView: MapDelegate {
    func updateGoogleMapPin(handler: (GMSMarker) -> Void) {
        guard let marker = marker else { return }
        handler(marker)
    }
}

