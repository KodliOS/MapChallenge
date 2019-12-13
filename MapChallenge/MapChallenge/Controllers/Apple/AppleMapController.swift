//
//  AppleMapController.swift
//  MapChallenge
//
//  Created by Berk Batuhan ŞAKAR on 8.12.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import UIKit
import MapKit
import Contacts

final class AppleMapController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthorizationStatus()
        setupAppleMap()
        showMousoleumOnMap()
        
    }
    
    func setupAppleMap() {
        mapView.delegate = self
        let location = CLLocation(latitude: 39.9251, longitude: 32.8368)
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 7000, longitudinalMeters: 7000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //show mousoleum on map
    //Haritada Anıt Mezar'ı göster
    func showMousoleumOnMap(){
        let mousoleum = Mousoleum(title: "Anıtkabir", locationName: "Türkiye'nin ilk cumhurbaşkanı Mustafa Kemal Atatürk'ün, Ankara Anıttepe'de bulunan anıt mezarıdır.", coordinate: CLLocationCoordinate2D(latitude: 39.925054,longitude: 32.8369439))
        mapView.addAnnotation(mousoleum)
    }
    
    
    
    let locationMananger = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationMananger.requestWhenInUseAuthorization()
        }
    }
    
   
    
}

extension AppleMapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Mousoleum else { return  nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeudedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeudedView.annotation = annotation
            view = dequeudedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: -5)
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Mousoleum
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}

