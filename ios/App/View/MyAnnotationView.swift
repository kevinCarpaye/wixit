//
//  AnnotationView.swift
//  App
//
//  Created by Kevin on 05/12/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotationView: MKAnnotationView {
    
    var controller: ShopController?
    
    init(controller: ShopController, annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.controller = controller
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        SetupAnnotation()
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super .init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        SetupAnnotation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        SetupAnnotation()
        
    }
    
    func SetupAnnotation() {
        image = UIImage(named: "marker")
        canShowCallout = true
        
        leftCalloutAccessoryView = SetupLeftButton()
        detailCalloutAccessoryView = SetupCenter()
        rightCalloutAccessoryView = SetupRightButton()

    }
    
    func SetupLeftButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(named: "distance"), for: .normal)
        button.addTarget(self, action: #selector(GpsChoice), for: .touchUpInside)
        return button
    }
    
    func SetupRightButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(named: "detail"), for: .normal)
        button.addTarget(self, action: #selector(details), for: .touchUpInside)
        return button
    }
    
    func SetupCenter() -> UILabel {
        //guard let anno = annotation as? Annotation else { return nil }
        let anno = annotation as? Annotation
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        label.text = anno?.shop.adress
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }
    
    @objc func details() {
        guard let anno = annotation as? Annotation else { return }
        controller?.toDeails(shop: anno.shop)
        //NotificationCenter.default.post(name: Notification.Name("detail"), object: anno.shop)
    }
    
     func GoogleMaps() {
        guard let anno = annotation as? Annotation else { return }
        if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(anno.shop.latitude),\(anno.shop.longitude)&directionsmode=driving") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func Maps() {
        guard let anno = annotation as? Annotation else { return }
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(anno.shop.latitude), longitude: CLLocationDegrees(anno.shop.longitude))
        let placemark = MKPlacemark(coordinate: location)
        let options = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        let map = MKMapItem(placemark: placemark)
        map.openInMaps(launchOptions: options)
    }
    
    @objc func GpsChoice() {
        let alert = UIAlertController(title: "Itinéraire", message: "", preferredStyle: .actionSheet)
        
        let googleMaps = UIAlertAction(title: "Google Maps", style: .default) { (UIAlertAction) in
            self.GoogleMaps()
        }
        
        let maps = UIAlertAction(title: "Plans", style: .default) { (UIAlertAction) in
            self.Maps()
        }
        
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        alert.addAction(googleMaps)
        alert.addAction(maps)
        alert.addAction(cancel)
        
        controller?.present(alert, animated: true, completion: nil)
    }
    
}
