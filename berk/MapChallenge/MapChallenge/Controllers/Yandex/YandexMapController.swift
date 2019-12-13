//
//  YandexMapController.swift
//  MapChallenge
//
//  Created by Berk Batuhan ŞAKAR on 8.12.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import UIKit
import YandexMapKit

class YandexMapController: UIViewController {
    
    
    @IBOutlet weak var mapView: YMKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        YMKMapKit.setApiKey("312c437d-d817-4e9b-8c71-dc594f5233ae")
        mapView.mapWindow.map.move(
        with: YMKCameraPosition.init(target: YMKPoint(latitude: 55.751574, longitude: 37.573856), zoom: 15, azimuth: 0, tilt: 0),
        animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
        cameraCallback: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
