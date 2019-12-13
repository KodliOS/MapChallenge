//
//  Mausoleum.swift
//  MapChallenge
//
//  Created by Berk Batuhan ŞAKAR on 8.12.2019.
//  Copyright © 2019 Berk Batuhan ŞAKAR. All rights reserved.
//

import MapKit
import Contacts

//NSObject gerekli çünkü MKAnnotation bir NSObjectProtocol
//MKAnnotation coordinate özelliğini gerektirir.
//Pin'e tıklandığında ek açıklama istiyorsak title ve subtitle kullanılır.
class Mousoleum: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    func mapItem() -> MKMapItem {
              let addressDict = [CNPostalAddressStreetKey: subtitle!]
              let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
              let mapItem = MKMapItem(placemark: placemark)
              mapItem.name = title
              return mapItem
          }
}

extension Mousoleum
{
  public var subtitle: String? {
    return self.locationName
  }
}


