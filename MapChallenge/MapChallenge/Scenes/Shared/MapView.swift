//
//  MapView.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 7.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import MapKit

enum MapType {
    case `default`
    case google
    case yandex
}

class MapView: UIView {
    
    var type: MapType
    
    var safeArea: UILayoutGuide!
    var layout = Layout()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Map view"
        label.sizeToFit()
        label.center = self.center
        return label
    }()
    
    init(for vc: UIViewController, type: MapType) {
        self.type = type
        safeArea = vc.view.layoutMarginsGuide
        super.init(frame: vc.view.frame)
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
    
    private func makeDefaultMap() {
        print("default")
        let mapView = MKMapView()
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        self.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: layout.mapMargins.left).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -layout.mapMargins.bottom).isActive = true
        mapView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -layout.mapMargins.right).isActive = true
        mapView.topAnchor.constraint(equalTo: self.topAnchor, constant: layout.mapMargins.top).isActive = true
    }
    
    private func makeGoogleMap() {
        print("google")
    }
    
    private func makeYandexMap() {
        print("yandex")
    }
    
    struct Layout {
        var mapMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
