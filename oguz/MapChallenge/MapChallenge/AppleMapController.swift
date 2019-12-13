//
//  AppleMapController.swift
//  MapChallenge
//
//  Created by Oguz on 7.12.2019.
//  Copyright © 2019 Oguz. All rights reserved.
//
import UIKit
import MapKit

class AppleMapController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    private var locationManager: CLLocationManager?
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        centerMapOnUserLocation()
    }
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager?.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
