//
//  ListArticleViewCell.swift
//  App
//
//  Created by Kévin CARPAYE on 06/11/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

class ListArticleViewCell: UITableViewCell {
    
    var divArticle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var articleName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 3
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
        self.selectionStyle = .none
    }
    
    func SetupViews() {
        setupArticleDiv()
        SetupArticleName()
        SetupArticleImage()
        SetupShopName()
        SetupShopPrice()
    }
    
    func setupArticleDiv() {
        addSubview(divArticle)
        NSLayoutConstraint.activate([
            divArticle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            divArticle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            divArticle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            divArticle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        divArticle.backgroundColor = .white
        //divArticle.layer.cornerRadius = CGFloat(10.0)
        divArticle.layer.shadowOpacity = 0.3
        divArticle.layer.shadowOffset = CGSize(width: 3, height: 3)
        divArticle.layer.contentsGravity = CALayerContentsGravity.center
    }
    
    func SetupArticleName() {
        divArticle.addSubview(articleName)
        NSLayoutConstraint.activate([
            articleName.topAnchor.constraint(equalTo: divArticle.topAnchor),
            articleName.centerXAnchor.constraint(equalTo: divArticle.centerXAnchor),
            articleName.widthAnchor.constraint(equalToConstant: 180),
            articleName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func SetupArticleImage() {
        divArticle.addSubview(articleImage)
        NSLayoutConstraint.activate([
            articleImage.topAnchor.constraint(equalTo: divArticle.topAnchor, constant: 10),
            articleImage.leftAnchor.constraint(equalTo: divArticle.leftAnchor, constant: 10),
            articleImage.widthAnchor.constraint(equalToConstant: 80),
            articleImage.bottomAnchor.constraint(equalTo: divArticle.bottomAnchor, constant: -10)
        ])
    }
    
    func SetupShopName() {
        divArticle.addSubview(shopName)
        NSLayoutConstraint.activate([
            shopName.topAnchor.constraint(equalTo: articleName.bottomAnchor),
            shopName.centerXAnchor.constraint(equalTo: divArticle.centerXAnchor),
            shopName.widthAnchor.constraint(equalToConstant: 180),
            shopName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func SetupShopPrice() {
        divArticle.addSubview(shopPrice)
        NSLayoutConstraint.activate([
            shopPrice.topAnchor.constraint(equalTo: divArticle.topAnchor, constant: 10),
            shopPrice.leftAnchor.constraint(equalTo: shopName.rightAnchor, constant: 10),
            shopPrice.widthAnchor.constraint(equalToConstant: 80),
            shopPrice.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

class HelpViewCell : UITableViewCell {
    
    let view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let helpText : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.text = ""
        label.numberOfLines = 2
        label.textAlignment = .justified
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews() {
        setupView()
        setupHelText()
    }
    
    func setupView() {
        self.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leftAnchor.constraint(equalTo: self.leftAnchor),
            view.rightAnchor.constraint(equalTo: self.rightAnchor),
            //view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            view.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupHelText() {
        view.addSubview(helpText)
        NSLayoutConstraint.activate([
            helpText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helpText.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //helpText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            helpText.widthAnchor.constraint(equalToConstant: 250),
            helpText.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


