//
//  GoogleMapsController.swift
//  MapChallenge
//
//  Created by Oguz on 7.12.2019.
//  Copyright © 2019 Oguz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps

class GoogleMapsController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
 private var locationManager: CLLocationManager?
    @IBOutlet weak var googleMapView: MKMapView!
    override func viewDidLoad() {
    super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
           let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
           view = mapView
     
        
    }
    
}
