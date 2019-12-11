//
//  MapViewContract.swift
//  MapChallenge
//
//  Created by Yasin Akbaş on 10.12.2019.
//  Copyright © 2019 Yasin Akbaş. All rights reserved.
//

import UIKit
import GoogleMaps
import YandexMapKit
import MapKit.MKMapView

protocol MapViewContract: UIView { }

extension MKMapView: MapViewContract { }
extension GMSMapView: MapViewContract { }
extension YMKMapView: MapViewContract { }
