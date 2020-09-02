//
//  NewArticleViewCell.swift
//  App
//
//  Created by Kévin CARPAYE on 8/19/20.
//  Copyright © 2020 Konex. All rights reserved.
//

import UIKit

class NewArticleViewCell: UICollectionViewCell {
    
    var view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var secondaryView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var image : UIImageView = {
        let image = UIImage(named: "AppIcon")?.withRenderingMode(.alwaysOriginal)
        let imageview = UIImageView(image: image)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleToFill
        return imageview
    }()
    
    var name : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.text = "test de la possibilité de mettre le nom de l'article"
        label.numberOfLines = 3
        //label.textAlignment = .center
        return label
    }()
    
    var article: SearchArticle? {
        didSet {
            print(article?.name)
            name.text = article?.name
            
            if ((article?.image!.count)! > 2) {
                let start = article!.image!.startIndex;
                let end = article!.image!.index((article?.image!.startIndex)!, offsetBy: 7)
                let range = start..<end
                let text = article?.image?[range]
                if ((text?.elementsEqual("https:/"))!) {
                    image.download(article!.image!)
                }
                else {
                    image.download(Urls().BASE_URL_IMAGE + article!.image!)
                }
            }
           
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupSecondaryView()
        setupImage()
        setupName()
    }
    
    func setupView() {
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupSecondaryView() {
        contentView.addSubview(secondaryView)
        NSLayoutConstraint.activate([
            secondaryView.topAnchor.constraint(equalTo: view.topAnchor),
            secondaryView.leftAnchor.constraint(equalTo: view.leftAnchor),
            secondaryView.rightAnchor.constraint(equalTo: view.rightAnchor),
            secondaryView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        secondaryView.layer.masksToBounds = true
        secondaryView.layer.cornerRadius = CGFloat(7.0)
    }
    
    func setupImage() {
        view.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: secondaryView.topAnchor),
            image.leftAnchor.constraint(equalTo: secondaryView.leftAnchor),
            image.rightAnchor.constraint(equalTo: secondaryView.rightAnchor),
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8)
            //image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            //image.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            //image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
    
    func setupName() {
        view.addSubview(name)
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            name.leftAnchor.constraint(equalTo: secondaryView.leftAnchor),
            name.rightAnchor.constraint(equalTo: secondaryView.rightAnchor),
            //name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -500)
            //name.heightAnchor.constraint(equalToConstant: contentView.frame.height / 2)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
