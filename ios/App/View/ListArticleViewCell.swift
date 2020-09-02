//
//  ListArticleViewCell.swift
//  App
//
//  Created by Kévin CARPAYE on 06/11/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

class ListArticleViewCell: UITableViewCell {
    
    var articleName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    var articleImage: UIImageView = {
        let image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var shopName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    var shopPrice: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SetupViews()
        self.backgroundColor = .white
    }
    
    func SetupViews() {
        SetupArticleName()
        SetupArticleImage()
        SetupShopName()
        SetupShopPrice()
    }
    
    func SetupArticleName() {
        addSubview(articleName)
        NSLayoutConstraint.activate([
            articleName.topAnchor.constraint(equalTo: self.topAnchor),
            articleName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            articleName.widthAnchor.constraint(equalToConstant: 180),
            articleName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func SetupArticleImage() {
        addSubview(articleImage)
        NSLayoutConstraint.activate([
            articleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            articleImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            articleImage.widthAnchor.constraint(equalToConstant: 80),
            articleImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    func SetupShopName() {
        addSubview(shopName)
        NSLayoutConstraint.activate([
            shopName.topAnchor.constraint(equalTo: articleName.bottomAnchor),
            shopName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            shopName.widthAnchor.constraint(equalToConstant: 180),
            shopName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func SetupShopPrice() {
        addSubview(shopPrice)
        NSLayoutConstraint.activate([
            shopPrice.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            shopPrice.leftAnchor.constraint(equalTo: shopName.rightAnchor, constant: 10),
            shopPrice.widthAnchor.constraint(equalToConstant: 80),
            shopPrice.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}


