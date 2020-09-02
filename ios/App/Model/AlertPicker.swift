//
//  File.swift
//  App
//
//  Created by Kévin CARPAYE on 02/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

class AlertPicker {
    
    private static let _display = AlertPicker()
    
    private var display: AlertPicker {
        return ._display
    }
    
    func Choice(controller: UIViewController, picker: UIImagePickerController, forUser: Bool,  imageButton: UIButton) {
        
        if forUser == true {
            let image1Changed = imageButton.imageView?.image
            let image2 = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
            if image1Changed != nil && image1Changed!.isEqual(image2) {
                let alert = UIAlertController(title: "Prendre une photo", message: "Quel média voulez-vous choisir ?", preferredStyle: .actionSheet)
                
                let camera = UIAlertAction(title: "Appareil photo", style: .default) { (action) in
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        picker.sourceType = .camera
                        controller.present(picker, animated: true, completion: nil)
                    }
                    else {
                        self.Error(controller: controller, error: "L'appareil photo n'est pas disponible")
                    }
                }
                
                let galery = UIAlertAction(title: "Gallerie", style: .default) { (action) in
                    picker.sourceType = .photoLibrary
                    controller.present(picker, animated: true, completion: nil)
                }
                
                let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
                
                alert.addAction(camera)
                alert.addAction(galery)
                alert.addAction(cancel)
                
                if let pop = alert.popoverPresentationController {
                    pop.sourceView = controller.view
                    pop.sourceRect = CGRect(x: controller.view.frame.midX, y: controller.view.frame.midY, width: 0, height: 0)
                    pop.permittedArrowDirections = []
                }
                
                controller.present(alert, animated: true, completion: nil)

            }
            else {
                let alert = UIAlertController(title: "Prendre une photo", message: "Quel média voulez-vous choisir ?", preferredStyle: .actionSheet)
                
                let delete = UIAlertAction(title: "Retirer la photo actuelle", style: .destructive) { (action) in
                    imageButton.setImage(image2, for: .normal)
                }
                
                let camera = UIAlertAction(title: "Appareil photo", style: .default) { (action) in
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        picker.sourceType = .camera
                        controller.present(picker, animated: true, completion: nil)
                    }
                    else {
                        self.Error(controller: controller, error: "L'appareil photo n'est pas disponible")
                    }
                }
                
                let galery = UIAlertAction(title: "Gallerie", style: .default) { (action) in
                    picker.sourceType = .photoLibrary
                    controller.present(picker, animated: true, completion: nil)
                }
                
                let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
                
                alert.addAction(delete)
                alert.addAction(camera)
                alert.addAction(galery)
                alert.addAction(cancel)
                
                if let pop = alert.popoverPresentationController {
                    pop.sourceView = controller.view
                    pop.sourceRect = CGRect(x: controller.view.frame.midX, y: controller.view.frame.midY, width: 0, height: 0)
                    pop.permittedArrowDirections = []
                }
                
                controller.present(alert, animated: true, completion: nil)
            }
        }
        else {
            let alert = UIAlertController(title: "Prendre une photo", message: "Quel média voulez-vous choisir ?", preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Appareil photo", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    picker.sourceType = .camera
                    controller.present(picker, animated: true, completion: nil)
                }
                else {
                    self.Error(controller: controller, error: "L'appareil photo n'est pas disponible")
                }
            }
            
            let galery = UIAlertAction(title: "Gallerie", style: .default) { (action) in
                picker.sourceType = .photoLibrary
                controller.present(picker, animated: true, completion: nil)
            }
            
            let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
            
            alert.addAction(camera)
            alert.addAction(galery)
            alert.addAction(cancel)
            
            if let pop = alert.popoverPresentationController {
                pop.sourceView = controller.view
                pop.sourceRect = CGRect(x: controller.view.frame.midX, y: controller.view.frame.midY, width: 0, height: 0)
                pop.permittedArrowDirections = []
            }
            
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    func Error (controller: UIViewController, error: String) {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .actionSheet)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        controller.present(alert, animated: true, completion: nil)
    }
}


