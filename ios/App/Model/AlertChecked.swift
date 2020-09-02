//
//  AlertChecked.swift
//  App
//
//  Created by Kévin CARPAYE on 02/10/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

class AlertChecked {
    
    private static let _display = AlertChecked()
    
    private var display: AlertChecked {
        return ._display
    }
    
    func Message(title: String, message: String, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            controller.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(ok)
        controller.present(alert, animated: true, completion: nil)
    }
}
