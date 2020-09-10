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
