//
//  Alert.swift
//  App
//
//  Created by Kévin CARPAYE on 20/10/2019.
//  Copyright © 2019 Konex. All rights reserved.
//
import UIKit

class Alert {
    
    private static let _display = AlertPicker()
    
    private var display: AlertPicker {
        return Alert._display
    }
    
    func displayAlert(controller: UIViewController, title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        controller.present(alert, animated: true, completion: nil)
        
    }
}
