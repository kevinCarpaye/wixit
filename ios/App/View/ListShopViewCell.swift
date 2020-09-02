//
//  ListShopViewCell.swift
//  App
//
//  Created by Kevin on 09/03/2020.
//  Copyright © 2020 Konex. All rights reserved.
//

import UIKit

class ListShopViewCell: UITableViewCell {
    
    var shopImage: UIImageView = {
        let image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let shopName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    let shopAdress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = .black
        label.textColor = UIColor(displayP3Red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        return label
    }()
    
    let distance: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.5)
        label.textAlignment = .center
        label.text = "-km"
        label.textColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.backgroundColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SetupViews()
        self.backgroundColor = .white
    }
    
    func SetupViews() {
        SetupShopImage()
        SetupDistance()
        SetupShopName()
        SetupShopAdress()
    }

     func SetupShopImage() {
            addSubview(shopImage)
            NSLayoutConstraint.activate([
                shopImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                shopImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                shopImage.widthAnchor.constraint(equalToConstant: 100),
                shopImage.heightAnchor.constraint(equalToConstant: 100),
            ])
        }
        
        func SetupDistance() {
            addSubview(distance)
            NSLayoutConstraint.activate([
                distance.bottomAnchor.constraint(equalTo: shopImage.bottomAnchor, constant: -15),
                distance.leftAnchor.constraint(equalTo: shopImage.leftAnchor, constant: 5),
                distance.widthAnchor.constraint(equalToConstant: 65),
                distance.heightAnchor.constraint(equalToConstant: 25)
            ])
        }
        
        func SetupShopName() {
            addSubview(shopName)
            NSLayoutConstraint.activate([
                shopName.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
                shopName.leftAnchor.constraint(equalTo: shopImage.rightAnchor, constant: 5),
                shopName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
                //shopName.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
        
        func SetupShopAdress() {
            addSubview(shopAdress)
            NSLayoutConstraint.activate([
                shopAdress.topAnchor.constraint(equalTo: shopName.topAnchor, constant: 20),
                shopAdress.leftAnchor.constraint(equalTo: shopImage.rightAnchor, constant: 10),
                shopAdress.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
                //shopAdress.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
