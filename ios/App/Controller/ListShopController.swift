//
//  ListShopController.swift
//  App
//
//  Created by Kevin on 08/12/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import CoreLocation


class ListShopController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate{
    
    let cellId = "cellid"
    
    var shop: [SearchShop] = []
    var user: [User] = []
    var isLogged : Bool = false
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation? = nil
    
    let profilPicture:UIButton = {
        let image = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        return button
    }()
    
    let searchBar: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.attributedPlaceholder = NSAttributedString(string:" Tapper ici le magasin à rechercher", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1)])
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
    
    let mapButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //let image = UIImage(named: "map")?.withRenderingMode(.alwaysOriginal)
        //button.setImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor(red: 25/255, green: 155/255, blue: 222/255, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(goToShopController), for: .touchUpInside)
        return button
    }()
    
    let mapImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "map")?.withRenderingMode(.alwaysOriginal)
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        //shop.removeAll()
        updateUser()
        RequestAll()
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SetupViews()
        tableview.delegate = self
        tableview.dataSource = self
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    private func SetupViews() {
        SetupNavigationBar()
        SetupSearchBar()
        SetupTableView()
        SetupButton()
        SetupImage()
        tableview.register(ListShopViewCell.self, forCellReuseIdentifier: cellId)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(HideKeyboard))
//        view.addGestureRecognizer(tap)
        
        searchBar.delegate = self
        searchBar.returnKeyType = .search
    }
    
    private func SetupNavigationBar() {
        navigationItem.title = "Magasins"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
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
//        let im = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
//        if (profilPicture.imageView?.image?.isEqual(im))! {
//            print("identique")
//            let AC = AuthController()
//            self.navigationController?.pushViewController(AC, animated: true)
//        }
//        else {
//            print("diiférent")
//            let UIC = UserInfoController()
//            self.navigationController?.pushViewController(UIC, animated: true)
//        }
        if self.isLogged == true {
            let UIC = UserInfoController()
            self.navigationController?.pushViewController(UIC, animated: true)
        }
        else {
            let AC = AuthController()
            self.navigationController?.pushViewController(AC, animated: true)
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
    
    private func SetupButton() {
        tableview.addSubview(mapButton)
        NSLayoutConstraint.activate([
            mapButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            mapButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            mapButton.widthAnchor.constraint(equalToConstant: 60),
            mapButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func SetupImage() {
        mapButton.addSubview(mapImage)
        NSLayoutConstraint.activate([
            mapImage.centerXAnchor.constraint(equalTo: mapButton.centerXAnchor),
            mapImage.centerYAnchor.constraint(equalTo: mapButton.centerYAnchor),
            mapImage.widthAnchor.constraint(equalToConstant: 40),
            mapImage.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func goToShopController() {
        let map = ShopController()
        self.navigationController?.pushViewController(map, animated: true)
    }
    
    private func RequestAll() {
        let url = Urls().BASE_URL + "shopList"
        
        AF.request(url).response { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                do {
                    let responseDecoded = try JSONDecoder().decode(getShop.self, from: data)
                    if responseDecoded.request == 1 {
//                        print(responseDecoded)
                        //self.SetupShops(shops: responseDecoded.shop)
                        
                        self.shop.removeAll()
                        var shops = [[String: Any]]()
                        for response in responseDecoded.shop {
                            let distance = self.Distance(latitude: response.latitude, longitude: response.longitude)
                            let data: [String : Any] = ["name" : response.name, "number" : response.number, "adress" : response.adress, "informations" : response.informations, "image" : response.image, "logo": response.logo, "latitude": response.latitude, "longitude": response.longitude, "distance" : distance]
                            shops.append(data)
                        }
                        var unsorted: [SearchShop] = []
                        for dictionary in shops as [[String: AnyObject]]{
                            let shop = SearchShop()
                            shop.name = (dictionary["name"] as! String)
                            shop.adress = (dictionary["adress"] as! String)
                            shop.image = (dictionary["image"] as! String)
                            shop.logo = (dictionary["logo"] as! String)
                            shop.informations = (dictionary["informations"] as! String)
                            shop.number = (dictionary["number"] as! String)
                            shop.distance = dictionary["distance"] as? Double
                            shop.latitude = dictionary["latitude"] as? Float
                            shop.longitude = dictionary["longitude"] as? Float
                            unsorted.append(shop)
                        }
                        self.shop = unsorted.sorted(by: {
                            Int($0.distance!) < Int($1.distance!)
                        })
                        self.tableview.reloadData()
                    }
                    else {
                        Alert().displayAlert(controller: self, title: "Erreur", message: responseDecoded.result)
                    }
                    
                    }
                    catch let error as NSError {
                        print(error)
                    }
            }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func RequestFetch(name: String?) {
        let url = Urls().BASE_URL + "shopListFetch"
        let parameters = ["name": name]
        AF.request(url, method: .get, parameters: parameters, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                do {
                    let responseDecoded = try JSONDecoder().decode(getShop.self, from: data)
                    if responseDecoded.request == 1 {
//                        print(responseDecoded)
                        //self.SetupShops(shops: responseDecoded.shop)
                        self.shop.removeAll()
                        var shops = [[String: Any]]()
                        for response in responseDecoded.shop {
                            let distance = self.Distance(latitude: response.latitude, longitude: response.longitude)
                            let data: [String : Any] = ["name" : response.name, "number" : response.number, "adress" : response.adress, "informations" : response.informations, "image" : response.image, "logo" : response.logo, "latitude": response.latitude, "longitude": response.longitude, "distance" : distance]
                            shops.append(data)
                        }
                        var unsorted: [SearchShop] = []
                        for dictionary in shops as [[String: AnyObject]]{
                            let shop = SearchShop()
                            shop.name = (dictionary["name"] as! String)
                            shop.adress = (dictionary["adress"] as! String)
                            shop.image = (dictionary["image"] as! String)
                            shop.logo = (dictionary["logo"] as! String)
                            shop.informations = (dictionary["informations"] as! String)
                            shop.number = (dictionary["number"] as! String)
                            shop.distance = dictionary["distance"] as? Double
                            shop.latitude = dictionary["latitude"] as? Float
                            shop.longitude = dictionary["longitude"] as? Float
                            unsorted.append(shop)
                        }
                        self.shop = unsorted.sorted(by: {
                            Int($0.distance!) < Int($1.distance!)
                        })
                        self.tableview.reloadData()
                    }
                    else {
                        Alert().displayAlert(controller: self, title: "Erreur", message: responseDecoded.result)
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
    
    @objc private func HideKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let shop = self.searchBar.text
        RequestFetch(name: shop)
        HideKeyboard()
        return true
    }
    
    private func Distance(latitude: Float, longitude: Float) -> Double {
        
        let userLocation = CLLocation(latitude: (self.currentLocation?.coordinate.latitude ?? 0.0), longitude: (self.currentLocation?.coordinate.longitude ?? 0.0))
        print("La latitude: \(latitude), la longitude \(longitude)")
        let shopLocation = CLLocation(latitude: CLLocationDegrees(exactly: latitude) ?? 0.0, longitude: CLLocationDegrees(exactly: longitude) ?? 0.0)
        
        let distance = shopLocation.distance(from: userLocation)
        let distanceInKm = distance / 1000
        print("Ce magasin est à \(String(format: "%.2f", distance))m de distance")
        print("Ce magasin est à \(String(format: "%.2f", distanceInKm))m de distance")
        return distance
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
}


extension ListShopController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shop.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ListShopViewCell
        if shop.count > 0 {
            let item = shop[indexPath.item]
            if (item.distance ?? 0 > 1000) {
                let distance = (item.distance)! / 1000
                cell.distance.text = String(format: "%.01fkm", distance)
            }
            else if (item.distance ?? 0 > 0 && item.distance ?? 0 < 1000) {
                cell.distance.text = "\(String(describing: item.distance))m"
            }
            cell.shopName.text = item.name
            cell.shopAdress.text = item.adress
            cell.shopImage.download(Urls().BASE_URL_IMAGE + item.image!)
            cell.selectionStyle = .none
            //tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sdc = ShopDetailController()
        if shop[indexPath.item].image != "" {
            sdc.shopImage.download(Urls().BASE_URL_IMAGE + shop[indexPath.item].image!)
        }
        else {
            sdc.shopImage.download(Urls().BASE_URL_IMAGE + shop[indexPath.item].logo!)
        }
        sdc.name = shop[indexPath.item].name!
        sdc.adress = shop[indexPath.item].adress!
        sdc.informations = shop[indexPath.item].informations
        print(shop[indexPath.item].logo)
        sdc.shopLogo.download(Urls().BASE_URL_IMAGE + shop[indexPath.item].logo!)
        sdc.number = shop[indexPath.item].number
        sdc.latitude = shop[indexPath.item].latitude!
        sdc.longitude = shop[indexPath.item].longitude!
        self.navigationController?.pushViewController(sdc, animated: true)
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
    
    struct Connectivity {
      static let sharedInstance = NetworkReachabilityManager()!
      static var isConnectedToInternet:Bool {
          return self.sharedInstance.isReachable
        }
    }
}
