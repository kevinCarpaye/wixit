//
//  ViewController.swift
//  MapProgrammatically
//
//  Created by Kevin on 15/01/2020.
//  Copyright © 2020 Kevin. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    let mapview : MKMapView = {
        let mapview = MKMapView()
        mapview.translatesAutoresizingMaskIntoConstraints = false
        mapview.mapType = .standard
        mapview.isZoomEnabled = true
        mapview.isScrollEnabled = false
        return mapview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(mapview)
        mapview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }


}

