//
//  NameController.swift
//  App
//
//  Created by Kévin CARPAYE on 14/04/2020.
//  Copyright © 2020 Konex. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class NameController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    let cellId = "cellid"
    
    var articles : [Articles] = []
    var user: [User] = []
    var distances: [Distance] = []
    
    var currentLocation: CLLocation? = nil
    var locationManager = CLLocationManager()
    
    let profilPicture:UIButton = {
        let image = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        return button
    }()

    let searchBar: UITextField = {
           let textfield = UITextField()
           textfield.translatesAutoresizingMaskIntoConstraints = false
           textfield.attributedPlaceholder = NSAttributedString(string:" Tapper le nom de l'article", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1)])
           textfield.clipsToBounds = true
           textfield.layer.cornerRadius = 10
           textfield.backgroundColor = UIColor(displayP3Red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
           textfield.textColor = .black
           return textfield
       }()
    
    let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .white
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestAlwaysAuthorization()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUser()
        SetupRightNavButton()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupViews() {
        SetupNavigationBar()
        SetupSearchBar()
        SetupTableView()
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(NameArticleViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    private func SetupNavigationBar() {
        self.navigationItem.title = "Recherche par nom"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        
    }
    
    private func SetupSearchBar () {
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func SetupTableView() {
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            tableview.widthAnchor.constraint(equalToConstant: view.frame.width),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        self.tableview.separatorStyle = .none
        
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
    
    private func updateUser() {
        CoreDataHelper().getUser { (user) in
            //print("Nombre d'utilisateur \(user?.count)")
            if user != nil && user!.count > 0 {
                print("il y a toujours quelqu'un")
                DispatchQueue.main.async {
                    self.user = user!
                    print("Le nombre d'utilisateur : \(self.user.count)")
                    let imageData = self.user[0].picture
                    //print(imageData)
                    let picture = UIImage(data: imageData!)?.withRenderingMode(.alwaysOriginal)
                    self.profilPicture.setImage(picture, for: .normal)
                }
            }
            else {
                print("il n'y a personne")
                DispatchQueue.main.async {
                    let picture = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
                    self.profilPicture.setImage(picture, for: .normal)
                }
            }
        }
        self.SetupRightNavButton()
    }
    
    @objc private func HideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let shop = self.searchBar.text
        //RequestFetch(name: shop)
        HideKeyboard()
        RequestFetch(name: shop)
        return true
    }
    
    private func RequestFetch(name: String?) {
        print(searchBar.text?.count)
        if (searchBar.text?.count) ?? 0 > 1 {
            let url = Urls().BASE_URL + "searchArticleByName"
                   var email = ""
                   if user.count > 0 {
                       email = self.user[0].email ?? ""
                   }
                   let parameters = ["name": name, "email": email]
                       AF.request(url, method: .get, parameters: parameters, headers: nil).responseJSON { (response) in
                           switch response.result {
                           case .success:
                               if let data = response.data {
                               do {
                                   let responseDecoded = try JSONDecoder().decode(GetArticle.self, from: data)
                                   if responseDecoded.request == 1 {
               //                        print(responseDecoded)
                                       //self.SetupShops(shops: responseDecoded.shop)
                                       self.articles.removeAll()
                                       for article in responseDecoded.response.articles {
                                           self.articles.append(article)
                                       }
                                       self.tableview.reloadData()
                                   }
                                   else {
                                       //Alert().displayAlert(controller: self, title: "Erreur", message: responseDecoded.result)
                                       let alert = UIAlertController(title: "Attention", message: "\(responseDecoded.result)🙏🏾)", preferredStyle: .alert)

                                       let yes = UIAlertAction(title: "Oui", style: .default) { (action) in
                                           let AAC = AddArticleController()
                                           self.navigationController?.pushViewController(AAC, animated: true)
                                       
                                       }

                                       let no = UIAlertAction(title: "Non", style: .destructive, handler: { (action) in
                                       })

                                       alert.addAction(yes)
                                       alert.addAction(no)
                                       self.present(alert, animated: true, completion: nil)
                                       
                                   }
                                   
                                   }
                                   catch let error as NSError {
                                       print(error)
                                   }
                           }
                               break
                           case .failure(let error):
                               Alert().displayAlert(controller: self, title: "Erreur interne", message: "Veuillez réessayer ultérieurement")
                               print(error)
                           }
                       }
        }
        else {
            self.articles.removeAll()
            tableview.reloadData()
            //return
        }
       
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            print("Found user's location: \(location.coordinate)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        Alert().displayAlert(controller: self, title: "Attention", message: "La géolocalisation est indispensable pour trouver les commerçants à proximité")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

}


extension NameController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NameArticleViewCell
        let article = articles[indexPath.item]
        cell.articleName.text = article.name
        print(article.image.count)
        if (article.image.count > 7) {
            let start = article.image.startIndex;
            let end = article.image.index((article.image.startIndex), offsetBy: 7)
            let range = start..<end
            let text = article.image[range]
            if ((text.elementsEqual("https:/"))) {
                cell.articleImage.download(article.image)
            }
            else {
                cell.articleImage.download(Urls().BASE_URL_IMAGE + article.image)
            }
        }
        
        //cell.articleImage.download(Urls().BASE_URL_IMAGE + article.image)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(articles[indexPath.row].image)
        print(articles[indexPath.row].name)
        shopsFetch(name: articles[indexPath.row].name)
    }
    
    private func Distance(latitude: Float, longitude: Float) -> Double {
        
        let userLocation = CLLocation(latitude: (self.currentLocation?.coordinate.latitude ?? 0.0), longitude: (self.currentLocation?.coordinate.longitude ?? 0.0))
        print("La latitude: \(latitude), la longitude \(longitude)")
        let shopLocation = CLLocation(latitude: CLLocationDegrees(exactly: latitude) ?? 0.0, longitude: CLLocationDegrees(exactly: longitude) ?? 0.0)
        
        let distance = shopLocation.distance(from: userLocation)
        let distanceInKm = distance / 1000
        print("Ce magasin est à \(String(format: "%.2f", distance))m de distance")
        print("Ce magasin est à \(String(format: "%.2f", distanceInKm))m de distance")
        print("Le nombre de distances dans le tableau \(self.distances.count)")
        return distance
    }
    
    private func shopsFetch(name: String) {
        let url =  Urls().BASE_URL + "searchArticleWithName/"
        var email = ""
        if user.count > 0 {
            email = self.user[0].email ?? ""
        }
        print("L'émail lors du fetch article \(email)")
                let parameters = ["name" : name, "email" : email]
                
                AF.request(url, method: .get, parameters: parameters, headers: nil).responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            do {
                                let responseDecoded = try JSONDecoder().decode(GetArticleWithCBStuct.self, from: data)
                                if responseDecoded.request == 1 {
                                    let SAC = SearchArticleController(collectionViewLayout: UICollectionViewFlowLayout())
        //                            SAC.articleName = responseDecoded.response.article.articleName
        //                            SAC.articleBarcode = code
        //                            SAC.articleDescriptions = responseDecoded.response.article.articleDescription
        //                            SAC.articleType = responseDecoded.response.article.articleType
        //                            SAC.articleImage = responseDecoded.response.article.articleImage
        //                            SAC.articleCreatedAt = responseDecoded.response.article.articleCreatedAt
                                    
                                    
                                    var articles = [[String: Any]]()
                                    
                                    for response in responseDecoded.response.article {
                                        let data: [String: Any] = ["name" : response.name, "barcode" : response.barcode, "description" : response.description, "type" : response.type, "image" : response.image, "createdAt" : response.createdAt ]
                                        
                                        articles.append(data)
                                        print("\(articles.count) articles")
                                    }
                                    print(articles.count)
                                    
                                    var shops = [[String: Any]]()
                                    
                                    for response in responseDecoded.response.shops {
                                        
                                        let distance = self.Distance(latitude: response.latitude, longitude: response.longitude)
                                        let data: [String : Any] = ["name" : response.name, "number" : response.number, "adress" : response.adress, "informations" : response.informations, "image" : response.logo, "price_base" : response.price_base, "price": response.price, "link": response.link, "date_start": response.date_start, "date_end": response.date_end, "stock" : response.stock, "latitude": response.latitude, "longitude": response.longitude, "distance" : distance]
                                        
                                        shops.append(data)
                                        
                                        print("\(shops.count) magasins")
                                    }
                                    SAC.articles = articles
                                    SAC.shops = shops
                                    self.navigationController?.pushViewController(SAC, animated: true)
                                }
                                else {
                                    
                                }
        //                        print(responseDecoded.response.article.articleName)
        //                        print(responseDecoded.response.article.articleCreatedAt)
                            }
                            catch let error as NSError {
                                print(error)
                            }
                        }
                        break
                    case .failure(let error):
                        print(error)
                        Alert().displayAlert(controller: self, title: "Problème de connexion", message: "Vous n'êtes pas connecté à internet.")
                    }
                }
    }
    
    struct Connectivity {
      static let sharedInstance = NetworkReachabilityManager()!
      static var isConnectedToInternet:Bool {
          return self.sharedInstance.isReachable
        }
    }
    
}
