//
//  AppleMapController.swift
//  MapChallenge
//
//  Created by Oguz on 7.12.2019.
//  Copyright © 2019 Oguz. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AppleMapController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  
   private var locationManager: CLLocationManager?
    
    @IBOutlet weak var mapView: MKMapView!

    let regionRadius: Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        centerMapOnUserLocation()
        
    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager?.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        
    }
    
}
