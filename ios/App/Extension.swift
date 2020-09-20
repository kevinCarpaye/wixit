//
//  Extension.swift
//  App
//
//  Created by Kévin CARPAYE on 04/11/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func download(_ urlString: String) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let imageData = data, let image = UIImage(data: imageData) else {return}
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

extension UITextField {
    
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func shake() {
        self.layer.borderColor = UIColor.red.cgColor
        
        let shakeAnimation = CAKeyframeAnimation(keyPath: "position.x")
        
        shakeAnimation.values = [0, -15, 15, -15, 15, 0]
        
        shakeAnimation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
        
        shakeAnimation.duration = 0.4
        
        shakeAnimation.isAdditive = true
        
        self.layer.add(shakeAnimation, forKey: nil)
    }
}

extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 1
        pulse.fromValue = 0.95
        pulse.toValue = 1
        //pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1
        
        layer.add(pulse, forKey: nil)
    }
}

extension UITableViewCell {
    
    func flash() {
        
        let flash = CASpringAnimation(keyPath: "opacity")
        flash.duration = 1
        flash.fromValue = 1
        flash.toValue = 0.5
        flash.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        layer.add(flash, forKey: nil)
    }
}
