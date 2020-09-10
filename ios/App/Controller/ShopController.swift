//
//  ShopControllerViewController.swift
//  App
//
//  Created by Kévin CARPAYE on 26/11/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class ShopController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    
    var shop: [ShopList] = []
    var user : [User] = []
    var isLogged : Bool = false
    
    let profilPicture:UIButton = {
                let image = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
                let button = UIButton(type: .system)
                button.setImage(image, for: .normal)
                return button
            }()
    
    let mapButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //let image = UIImage(named: "map")?.withRenderingMode(.alwaysOriginal)
        //button.setImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor(red: 25/255, green: 155/255, blue: 222/255, alpha: 0.5)
        button.clipsToBounds = true
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(goToListShopController), for: .touchUpInside)
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
    
    let mapImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "other")?.withRenderingMode(.alwaysOriginal)
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var window: UIWindow?
    var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var userPosition: CLLocation?
    //The range (meter) of how much we want to see arround the user's location
    let distanceSpan: Double = 500
    
    override func viewWillAppear(_ animated: Bool) {
        updateUser()
        RequestAll()
        self.tabBarController?.tabBar.isHidden = false
        //setupShop()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        SetupNavigationBar()
        //SetupSearchBar()
        
        SetupMapView()
        SetupSearchBar()
        SetupButton()
        SetupImage()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HideKeyboard))
        view.addGestureRecognizer(tap)
        
        searchBar.delegate = self
        searchBar.returnKeyType = .search
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print(self.shop.count)
            self.setupAnnotation()
            self.centreMap()
        }
        
    }
    
    private func SetupNavigationBar() {
        navigationItem.title = "Carte"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    private func SetupMapView() {
        self.mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: (self.window?.frame.width)!, height: (self.window?.frame.height)!))
        self.view.addSubview(self.mapView!)
        mapView.delegate = self
        
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
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
    
    private func SetupButton() {
        view.addSubview(mapButton)
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
//            let im = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
//            if (profilPicture.imageView?.image?.isEqual(im))! {
//                print("identique")
//                let AC = AuthController()
//                self.navigationController?.pushViewController(AC, animated: true)
//            }
//            else {
//                print("diiférent")
//                let UIC = UserInfoController()
//                self.navigationController?.pushViewController(UIC, animated: true)
//            }
            if self.isLogged == true {
                let UIC = UserInfoController()
                self.navigationController?.pushViewController(UIC, animated: true)
            }
            else {
                let AC = AuthController()
                self.navigationController?.pushViewController(AC, animated: true)
            }
        }
    
//    func SetupSearchBar() {
//        let search = UISearchController(searchResultsController: nil)
//        search.searchResultsUpdater = self
//        search.obscuresBackgroundDuringPresentation = true
//        search.searchBar.placeholder = "Type something here to search"
//        navigationItem.searchController = search
//    }
        
    private func centreMap(){
        if shop.count > 0 {
            let lat = shop[0].latitude
            let long = shop[0].longitude
            print(lat)
            let location = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
            let region_radious = 10000
            let region = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: CLLocationDistance(region_radious), longitudinalMeters: CLLocationDistance(region_radious))
            mapView.setRegion(region, animated: true)
        }
    }
    
    @objc private func HideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func goToListShopController() {
        let list = ListShopController()
        self.navigationController?.pushViewController(list, animated: true)
    }
    
    private func setupAnnotation() {
        for sho in self.shop {
            let annotation = Annotation(sho)
            mapView.addAnnotation(annotation)
        }
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
                        print(responseDecoded)
                        //self.SetupShops(shops: responseDecoded.shop)
                        
                        for shop in responseDecoded.shop {
                            self.shop.append(shop)
                        }
                        self.setupAnnotation()
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
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                do {
                    let responseDecoded = try JSONDecoder().decode(getShop.self, from: data)
                    if responseDecoded.request == 1 {
                        print(responseDecoded)
                        //self.SetupShops(shops: responseDecoded.shop)
                        self.shop.removeAll()
                        for shop in responseDecoded.shop {
                            self.shop.append(shop)
                        }
                        let allAnnotations = self.mapView.annotations
                        self.mapView.removeAnnotations(allAnnotations)
                        self.setupAnnotation()
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
    
   func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
        let reuseIdentifier = "reuseID"
            
    if annotation.isKind(of: MKUserLocation.self) {
                    return nil }
                if let anno = annotation as? Annotation { 
                    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
                    if annotationView == nil {
                        
                        //Override
                        annotationView = MyAnnotationView(controller: self, annotation: anno, reuseIdentifier: reuseIdentifier)
                        
        //                annotationView = MonAnnotationView(controller: self, annotation: anno, reuseIdentifier: reuseIdentifier)
                        
        //                annotationView = MKAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
        //                annotationView?.image = UIImage(named: "placeholder")
        //                annotationView?.canShowCallout = true
                        return annotationView
                    } else {
                       return annotationView
                    }
                }
                return nil
    }
    
    func toDeails(shop: ShopList) {
        print("sdfghjkl")
        let sdc = ShopDetailController()
        if shop.image != "" {
            sdc.shopImage.download(Urls().BASE_URL_IMAGE + shop.image)
        }
        else {
            sdc.shopImage.download(Urls().BASE_URL_IMAGE + shop.logo)
        }
        sdc.shopLogo.download(shop.logo)
        sdc.name = shop.name
        sdc.number = shop.number
        sdc.adress = shop.adress
        sdc.informations = shop.informations
        sdc.latitude = shop.latitude
        sdc.longitude = shop.longitude
        self.navigationController?.pushViewController(sdc, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let shop = self.searchBar.text
        RequestFetch(name: shop)
        HideKeyboard()
        //self.centreMap()
        return true
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }

}


//extension ShopController : UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else { return }
//        RequestFetch(name: text)
//    }
//
//
//
//
//}
