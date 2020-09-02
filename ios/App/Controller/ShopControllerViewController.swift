//
//  ShopControllerViewController.swift
//  App
//
//  Created by Kévin CARPAYE on 26/11/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import MapKit

class ShopControllerViewController: UIViewController, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var mapView: MKMapView?
    var locationManager: CLLocationManager?
    //The range (meter) of how much we want to see arround the user's location
    let distanceSpan: Double = 500

    override func viewDidLoad() {
        super.viewDidLoad()

        window = UIWindow(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        
        self.mapView = MKMapView(frame: CGRect(x: 0, y: 20, width: (self.window?.frame.width)!, height: (self.window?.frame.height)!))
        self.view.addSubview(self.mapView!)
        
        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 200
            locationManager.startUpdatingLocation()
        }
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
