//
//  GoogleMapsController.swift
//  MapChallenge
//
//  Created by Oguz on 7.12.2019.
//  Copyright © 2019 Oguz. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapsController: UIViewController, CLLocationManagerDelegate  {
 private var locationManager: CLLocationManager?
    @IBOutlet weak var googleMapView: GMSMapView!
    override func viewDidLoad() {
    super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        let camera = GMSCameraPosition.camera(withTarget: (locationManager?.location!.coordinate)!, zoom: 15)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        mapView.isMyLocationEnabled = true
        
    }
    

}
