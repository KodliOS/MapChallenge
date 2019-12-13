//
//  GoogleMapController.swift
//  MapChallenge
//
//  Created by Berk Batuhan ŞAKAR on 8.12.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapController: UIViewController {
    
    var mapView: GMSMapView?
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    
    /// A default location to use when location permission is not granted.
    let defaultLocation = CLLocation(latitude: 39.9251, longitude: 32.8368)
    
    override func loadView() {
        let camera = GMSCameraPosition(latitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 39.9251, longitude: 32.8368)
        marker.title = "Anıtkabir"
        marker.snippet = "Ankara"
        marker.map = mapView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView?.delegate = self
        GMSServices.provideAPIKey("AIzaSyDshkRlRnp2tH_U1i3QML0GvPsfQzRkYLw")
        mapView!.settings.myLocationButton = true
        mapView!.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        //        view.addSubview(mapView)
        //        mapView.isHidden = true
        
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        
        
        
    }
    
}

extension GoogleMapController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        
        
        if mapView!.isHidden {
            mapView!.isHidden = false
            mapView!.camera = camera
        } else {
            mapView!.animate(to: camera)
        }
        self.locationManager.stopUpdatingLocation()
    }
    
    // Handle authorization for the location manager. - Konum yöneticisinin yetkilendirmesini gerçekleştirin.
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Konum erişimi kısıtlandı!")
        case .denied:
            print("Kullanıcı konuma erişimi reddetti!")
            // Display the map using the default location.
            mapView!.isHidden = false
        case .notDetermined:
            print("Konum durumu belirlenmedi!")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            //            mapView.isHidden = true
            print("Konum izni başarıyla alındı!")
            mapView?.isMyLocationEnabled = true
        default:
            print("default")
        }
    }
    
    // Handle location manager errors. - Konum yöneticisi hatalarını işleyin.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Hata: \(error)")
    }
}

extension GoogleMapController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("\(coordinate.latitude), \(coordinate.longitude) kordinatlarına dokundunuz.")
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.title = "Anıtkabir"
        marker.snippet = "Ankara"
        marker.map = mapView
    }
}
