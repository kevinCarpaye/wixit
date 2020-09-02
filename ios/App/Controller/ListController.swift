//
//  ListController.swift
//  App
//
//  Created by Kévin CARPAYE on 05/11/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

class ListController: UIViewController {
    
    var articles: [ListeArticle] = []
    var user: [User] = []
    var total = 0.0
    
    let cellId = "cellid"
    
    let profilPicture:UIButton = {
        let image = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        return button
    }()
    
    var totalDiv: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    var totalImage: UIImageView = {
        let image = UIImage(named: "panier")?.withRenderingMode(.alwaysOriginal)
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        //view.backgroundColor = .red
        return view
    }()
    
    var totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Total estimé:"
        label.textAlignment = .center
        return label
    }()
    
    var totalPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var tableview: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        SetupRightNavButton()
        updateArticles()
        updateUser()
        self.tabBarController?.tabBar.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.CalculPrice()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Liste"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        view.backgroundColor = .white
        tableview.delegate = self
        tableview.dataSource = self
        //sleep(1/2)
        SetupViews()
        tableview.register(ListArticleViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func updateUser() {
        CoreDataHelper().getUser { (user) in
            //print("Nombre d'utilisateur \(user?.count)")
            if user != nil && user!.count > 0 {
                //print("il y a toujours quelqu'un")
                DispatchQueue.main.async {
                    self.user = user!
                    //print("Le nombre d'utilisateur : \(self.user.count)")
                    let imageData = self.user[0].picture
                    //print(imageData)
                    let picture = UIImage(data: imageData!)?.withRenderingMode(.alwaysOriginal)
                    self.profilPicture.setImage(picture, for: .normal)
                }
            }
            else {
                //print("il n'y a personne")
                DispatchQueue.main.async {
                    let picture = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
                    self.profilPicture.setImage(picture, for: .normal)
                }
            }
        }
        self.SetupRightNavButton()
    }
    
//    func UserPictureCheck(image: UIImage?) -> String {
//        if (image?.isEqual(profilPicture.imageView?.image))! {
//            return "Indentique"
//        }
//        else {
//            return "Différent"
//        }
//    }
    
    
    private func updateArticles() {
        CoreDataHelper().getArticles { (articles) in
            if articles != nil {
                DispatchQueue.main.async {
                    self.articles = articles!
                    self.tableview.reloadData()
                    print(self.articles.count)
                    //print("\(self.articles[0].status) pour l'article à l'index 0")
                }
            }
        }
    }
    
    private func SetupViews() {
        SetupTotalDiv()
        SetupTableview()
    }
    
    private func SetupTotalDiv() {
        view.addSubview(totalDiv)
        NSLayoutConstraint.activate([
            totalDiv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            totalDiv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalDiv.widthAnchor.constraint(equalToConstant: 300),
            totalDiv.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        totalDiv.addSubview(totalImage)
        NSLayoutConstraint.activate([
            totalImage.centerYAnchor.constraint(equalTo: totalDiv.centerYAnchor),
            totalImage.leftAnchor.constraint(equalTo: totalDiv.leftAnchor, constant: 20),
            totalImage.widthAnchor.constraint(equalToConstant: 70),
            totalImage.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        totalDiv.addSubview(totalLabel)
        NSLayoutConstraint.activate([
            totalLabel.centerYAnchor.constraint(equalTo: totalDiv.centerYAnchor),
            totalLabel.leftAnchor.constraint(equalTo: totalImage.rightAnchor),
            totalLabel.widthAnchor.constraint(equalToConstant: 100),
            totalLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        totalDiv.addSubview(totalPrice)
        NSLayoutConstraint.activate([
            totalPrice.centerYAnchor.constraint(equalTo: totalDiv.centerYAnchor),
            totalPrice.leftAnchor.constraint(equalTo: totalLabel.rightAnchor),
            totalPrice.widthAnchor.constraint(equalToConstant: 100),
            totalPrice.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func SetupTableview() {
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: totalDiv.bottomAnchor, constant: 20),
            tableview.widthAnchor.constraint(equalToConstant: view.frame.width),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func SetupRightNavButton() {
        profilPicture.translatesAutoresizingMaskIntoConstraints = false
        profilPicture.clipsToBounds = true
        profilPicture.layer.cornerRadius = 20
        profilPicture.setBackgroundImage(profilPicture.imageView?.image, for: .normal)
        profilPicture.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profilPicture.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profilPicture.addTarget(self, action: #selector(self.test), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profilPicture)
    }
    
    @objc private func test() {
        let im = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
        if (profilPicture.imageView?.image?.isEqual(im))! {
            print("identique")
            let AC = AuthController()
            self.navigationController?.pushViewController(AC, animated: true)
        }
        else {
            print("diiférent")
            let UIC = UserInfoController()
            self.navigationController?.pushViewController(UIC, animated: true)
        }
    }
    
    private func CalculPrice() {
        self.total = 0.0
        self.totalPrice.text = "\(String(format: "%.2f", self.total))€"
        print("rentré dans le calcul price")
        if articles.count != 0 {
            DispatchQueue.main.async {
                print("Rentré dans les calculs")
                for article in self.articles {
                    self.total += article.price
                }
                self.totalPrice.text = "\(String(format: "%.2f", self.total))€"
            }
        }
    }
    
    @objc private func GoToUserProfil() {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

}

extension ListController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ListArticleViewCell
        let item = articles[indexPath.item]
        cell.articleName.text = item.name
        cell.shopName.text = item.shop
        cell.shopPrice.text = "\(item.price)€"
        if ((item.image!.count) > 2) {
            let start = item.image!.startIndex;
            let end = item.image!.index((item.image!.startIndex), offsetBy: 7)
            let range = start..<end
            let text = item.image![range]
            if ((text.elementsEqual("https:/"))) {
                cell.articleImage.download(item.image!)
            }
            else {
                cell.articleImage.download(Urls().BASE_URL_IMAGE + item.image!)
            }
        }
        
         cell.selectionStyle = .none
//        tableview.cellForRow(at: indexPath)?.backgroundColor = .green
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        if articles[indexPath.item].status == false {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .white
            print("C'est du false")
        }
        else {
            tableView.cellForRow(at: indexPath)?.backgroundColor = .green
            print("C'est du non false")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Supprimer") { (action, indexPath) in
            // delete item at indexPath
            let price = self.articles[indexPath.item].price
            CoreDataHelper().DeleteArticle(self.articles[indexPath.item])
            self.updateArticles()
            self.total = self.total - price
            self.totalPrice.text = "\(String(format: "%.2f", self.total))€"
            if self.total == 0 {
                self.totalPrice.text = "\(0.0)€"
            }
            
        }

        let share = UITableViewRowAction(style: .normal, title: "Panier") { (action, indexPath) in
            //print(self.articles[indexPath.item].status)
            if self.articles[indexPath.item].status == false  {
                self.articles[indexPath.item].status = true
                print("-------------------------------")
                print(self.articles[indexPath.item].status)
                self.tableview.cellForRow(at: indexPath)?.backgroundColor = .green
                CoreDataHelper().UpdateArticleStatus(self.articles[indexPath.item], newValue: true)
            }
            else if self.articles[indexPath.item].status == true  {
                self.articles[indexPath.item].status = false
                print("--------------------------------")
                print(self.articles[indexPath.item].status)
                self.tableview.cellForRow(at: indexPath)?.backgroundColor = .white
                CoreDataHelper().UpdateArticleStatus(self.articles[indexPath.item], newValue: false)
            }
            
        }
        if self.articles[indexPath.item].status == false {
            share.backgroundColor = UIColor.init(red: 55/255, green: 165/255, blue: 3/255, alpha: 1)
        }
        else {
            share.backgroundColor = UIColor.init(red: 244/255, green: 139/255, blue: 4/255, alpha: 1)
        }

        return [delete, share]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--------")
    }
    
}
