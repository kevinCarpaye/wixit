 //
//  Annotation.swift
//  App
//
//  Created by Kevin on 04/12/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

 import UIKit
 import MapKit
 
 class Annotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var shop: ShopList
    var title: String?
    
    init (_ shop: ShopList) {
        self.shop = shop
        let cordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(shop.latitude), longitude: CLLocationDegrees(shop.longitude))
        self.coordinate = cordinates
        self.title = shop.name
    }
 }
