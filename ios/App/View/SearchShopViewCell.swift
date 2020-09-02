//
//  ListShopCell.swift
//  App
//
//  Created by Kévin CARPAYE on 03/11/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

class SeachShopHeaderCell: UICollectionViewCell {
    
    var divArticle: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
           return view
       }()
       
       var articleImage: UIImageView = {
           var image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
           var view = UIImageView(image: image)
           view.translatesAutoresizingMaskIntoConstraints = false
           view.contentMode = .scaleAspectFit
           return view
       }()
       
       var articleName: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 18)
            label.textAlignment = .center
            label.textColor = .black
            return label
       }()
    
    var article: SearchArticle? {
        didSet {
            print(article?.name)
            articleName.text = article?.name
            
            if ((article?.image!.count)! > 2) {
                let start = article!.image!.startIndex;
                let end = article!.image!.index((article?.image!.startIndex)!, offsetBy: 7)
                let range = start..<end
                let text = article?.image?[range]
                if ((text?.elementsEqual("https:/"))!) {
                    articleImage.download(article!.image!)
                }
                else {
                    articleImage.download(Urls().BASE_URL_IMAGE + article!.image!)
                }
            }
           
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupViews()
    }
    
    func SetupViews() {
        SetupArticleDiv()
        SetupArticleName()
        SetupArticleImage()
    }
    
    func SetupArticleDiv() {
        addSubview(divArticle)
        NSLayoutConstraint.activate([
            divArticle.topAnchor.constraint(equalTo: self.topAnchor),
            divArticle.leftAnchor.constraint(equalTo: self.leftAnchor),
            divArticle.rightAnchor.constraint(equalTo: self.rightAnchor),
            divArticle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
    func SetupArticleName() {
        addSubview(articleName)
        NSLayoutConstraint.activate([
            articleName.bottomAnchor.constraint(equalTo: divArticle.bottomAnchor, constant: -10),
            articleName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            articleName.widthAnchor.constraint(equalToConstant: 280),
            articleName.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func SetupArticleImage() {
        addSubview(articleImage)
        NSLayoutConstraint.activate([
            articleImage.bottomAnchor.constraint(equalTo: articleName.topAnchor, constant: -10),
            articleImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            articleImage.widthAnchor.constraint(equalToConstant: 160),
            articleImage.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchShopViewCell: UICollectionViewCell {
    
    var shop: SearchShop? {
        didSet {
            //print(shop?.name)
            worldLabel.text = shop?.name
            adressLabel.text = shop?.adress

            priceArticle.text = "\(shop?.price_base ?? 0)€"
            
            if (shop?.price)! > 0.0 {
               if self.setDateEnd() > self.setCurrentDate() {
                    articleSale.image = UIImage(named: "promo")
                    self.ChangeDateStartFormat(date: (shop?.date_start)!)
                    self.ChangeDateEndFormat(date: (shop?.date_end)!)
                    self.priceArticle.text = "\(shop?.price ?? 0)€"
                }
            }
//            else {
//                divSale.isHidden = true
//                articleSale.isHidden = true
//            }
//
            print("La distance est de \(shop?.distance)")
            
            if (shop?.distance ?? 0 > 1000) {
                let distance = (shop?.distance)! / 1000
                shopDistance.text = String(format: "%.01fkm", distance)
            }
            else if (shop?.distance ?? 0 > 0 && shop?.distance ?? 0 < 1000) {
                shopDistance.text = "\(String(describing: shop?.distance))m"
            }
            
            if (shop?.stock) ?? 0 >= 1 {
                articleStock.text = "\(shop?.stock ?? 0) restants"
            }
            if (shop?.stock) ?? 0 <= 1 {
                articleStock.text = "\(shop?.stock ?? 0) restant"
            }
            
            if (shop?.stock) ?? 0 <= 0 {
                articleStock.text = "-- restants"
            }
            
            logo.download((Urls().BASE_URL_IMAGE + shop!.image!))
            print(shop?.stock)
        }
        
    }
    
    var logo: UIImageView = {
        var image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        var view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var worldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var adressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 3
        return label
    }()
    
    var shopDistance: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: 0.7)
        return label
    }()
    
    var priceArticle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var divSale: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var articleSale: UIImageView = {
        var image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        var view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var date_start : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var date_end : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var articleStock: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetupViews()
    }
    
    func SetupViews() {
        backgroundColor = .yellow
        SetupShopLogo()
        SetupShopName()
        SetupShopAdress()
        SetupShopDistance()
        SetupPrice()
        SetupDivSale()
        SetupArticleStock()
    }
    
    func SetupShopLogo() {
        addSubview(logo)
        logo.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        logo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func SetupShopName() {
        addSubview(worldLabel)
        worldLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        worldLabel.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: 10).isActive = true
        worldLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        worldLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func SetupShopAdress() {
        addSubview(adressLabel)
        adressLabel.topAnchor.constraint(equalTo: worldLabel.bottomAnchor, constant: 10).isActive = true
        adressLabel.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: 10).isActive = true
        adressLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        adressLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func SetupShopDistance() {
        addSubview(shopDistance)
        shopDistance.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        shopDistance.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        shopDistance.widthAnchor.constraint(equalToConstant: 80).isActive = true
        shopDistance.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func SetupPrice() {
        addSubview(priceArticle)
        priceArticle.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 25).isActive = true
        priceArticle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        priceArticle.widthAnchor.constraint(equalToConstant: 80).isActive = true
        priceArticle.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func SetupDivSale() {
        addSubview(divSale)
        divSale.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 10).isActive = true
        divSale.leftAnchor.constraint(equalTo: priceArticle.rightAnchor, constant: 5).isActive = true
        divSale.widthAnchor.constraint(equalToConstant: 180).isActive = true
        divSale.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        SetupArticleSale()
        setupDates()
    }
    
    func SetupArticleSale() {
        addSubview(articleSale)
        articleSale.topAnchor.constraint(equalTo: divSale.topAnchor).isActive = true
        articleSale.leftAnchor.constraint(equalTo: divSale.leftAnchor).isActive = true
        articleSale.widthAnchor.constraint(equalToConstant: 70).isActive = true
        articleSale.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupDates() {
        addSubview(date_start)
        date_start.topAnchor.constraint(equalTo: divSale.topAnchor).isActive = true
        date_start.leftAnchor.constraint(equalTo: articleSale.rightAnchor).isActive = true
        date_start.rightAnchor.constraint(equalTo: divSale.rightAnchor).isActive = true
        date_start.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(date_end)
        date_end.topAnchor.constraint(equalTo: date_start.bottomAnchor).isActive = true
        date_end.leftAnchor.constraint(equalTo: articleSale.rightAnchor).isActive = true
        date_end.rightAnchor.constraint(equalTo: divSale.rightAnchor).isActive = true
        date_end.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func SetupArticleStock() {
        addSubview(articleStock)
        articleStock.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 15).isActive = true
        articleStock.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        articleStock.widthAnchor.constraint(equalToConstant: 90).isActive = true
        articleStock.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func ChangeDateStartFormat(date : String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let newFormat = DateFormatter()
        newFormat.dateFormat = "dd/MM/yyyy"
        if let newDate = formatter.date(from: date) {
            let trueDate = newFormat.string(from: newDate)
            self.date_start.text = "du \(trueDate)"
        }
    }
    
    func ChangeDateEndFormat(date : String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let newFormat = DateFormatter()
        newFormat.dateFormat = "dd/MM/yyyy"
        if let newDate = formatter.date(from: date) {
            let trueDate = newFormat.string(from: newDate)
            self.date_end.text = "du \(trueDate)"
        }
    }
    
    func setDateEnd() -> Int {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd"
        let date = dfmatter.date(from: (shop?.date_end)!)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        print("\(dateSt) est la date de début")
        return dateSt
    }
    
    func setCurrentDate() -> Int {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let dateStamp:TimeInterval = date.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        print("\(dateSt) est la date du jour")
        return dateSt
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
