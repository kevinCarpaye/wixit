//
//  NameArticleViewCell.swift
//  App
//
//  Created by Kévin CARPAYE on 16/04/2020.
//  Copyright © 2020 Konex. All rights reserved.
//

import UIKit
class NameArticleViewCell: UITableViewCell {
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SetupViews()
        self.backgroundColor = .white
    }
    
    func SetupViews() {
        SetupArticleImage()
        SetupArticleName()
    }
    
    func SetupArticleName() {
        addSubview(articleName)
        NSLayoutConstraint.activate([
            articleName.leftAnchor.constraint(equalTo: articleImage.rightAnchor, constant: 20),
            articleName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            articleName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            //articleName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            articleName.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func SetupArticleImage() {
        addSubview(articleImage)
        NSLayoutConstraint.activate([
            //articleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            articleImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            articleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            articleImage.widthAnchor.constraint(equalToConstant: 80),
            articleImage.heightAnchor.constraint(equalToConstant: 80)
            //articleImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
