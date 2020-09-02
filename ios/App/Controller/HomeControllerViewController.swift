//
//  HomeControllerViewController.swift
//  App
//
//  Created by Kévin CARPAYE on 8/19/20.
//  Copyright © 2020 Konex. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class HomeControllerViewController: UIViewController, CLLocationManagerDelegate {
    
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
    
    let text : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Ajouts récents"
        return label
    }()
    
    fileprivate let collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(NewArticleViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    let choiceView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Scanbutton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Scanner", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 0, green: 182/255, blue: 1, alpha: 0.8)
        button.clipsToBounds = true
        button.layer.cornerRadius = 22.5
        button.addTarget(self, action: #selector(Scan), for: .touchUpInside)
        return button
    }()
    
    let Searchbutton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Recherche", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 0, green: 182/255, blue: 1, alpha: 0.8)
        button.clipsToBounds = true
        button.layer.cornerRadius = 22.5
        button.addTarget(self, action: #selector(Search), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        updateUser()
        fetchNewArticle()
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        SetupRightNavButton()
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        setupText()
        setupCollectionView()
        setupChoiceView()
    }
    func SetupRightNavButton() {
        profilPicture.translatesAutoresizingMaskIntoConstraints = false
        profilPicture.clipsToBounds = true
        profilPicture.layer.cornerRadius = 20
        profilPicture.setBackgroundImage(profilPicture.imageView?.image, for: .normal)
        profilPicture.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profilPicture.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profilPicture.addTarget(self, action: #selector(self.test), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profilPicture)
    }
    
    func setupText() {
        view.addSubview(text)
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            text.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            text.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
            //text.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupCollectionView () {
        view.addSubview(collectionview)
        collectionview.backgroundColor = .white
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 10),
            collectionview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            collectionview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            collectionview.heightAnchor.constraint(equalTo: collectionview.widthAnchor)
            //collectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionview.delegate = self
        collectionview.dataSource = self
    }
    
    func setupChoiceView() {
        view.addSubview(choiceView)
        NSLayoutConstraint.activate([
            choiceView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            choiceView.widthAnchor.constraint(equalToConstant: view.frame.width),
            choiceView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40),
            choiceView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        setupScanButton()
        setupSearchButton()
    }
    
    func setupScanButton() {
        view.addSubview(Scanbutton)
        NSLayoutConstraint.activate([
            Scanbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Scanbutton.topAnchor.constraint(equalTo: choiceView.topAnchor, constant: 50),
            Scanbutton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            Scanbutton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    func setupSearchButton() {
        view.addSubview(Searchbutton)
        NSLayoutConstraint.activate([
            Searchbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Searchbutton.topAnchor.constraint(equalTo: Scanbutton.bottomAnchor, constant: 20),
            Searchbutton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            Searchbutton.heightAnchor.constraint(equalToConstant: 45)
        ])
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
    
    private func fetchNewArticle() {
        let url = Urls().BASE_URL + "/newArticles"
        
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let responseDecoded = try JSONDecoder().decode(GetArticle.self, from: data)
                        if responseDecoded.request == 1 {
                        //print(responseDecoded)
                        //self.SetupShops(shops: responseDecoded.shop)
                        self.articles.removeAll()
                        for article in responseDecoded.response.articles {
                            self.articles.append(article)
                        }
                        self.collectionview.reloadData()
                        print(self.articles.count)
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
    
    @objc private func Scan() {
        self.navigationController?.pushViewController(ScanController(), animated: true)
    }
    
    @objc private func Search() {
        self.navigationController?.pushViewController(NameController(), animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeControllerViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/1.2, height: collectionView.frame.width/1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewArticleViewCell
        cell.backgroundColor = .white
        cell.image.download(articles[indexPath.item].image)
        cell.name.text = articles[indexPath.item].name
        cell.layer.cornerRadius = CGFloat(7.0)
        cell.layer.shadowOpacity = 0.8
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        cell.layer.shadowRadius = CGFloat(5.0)
        //layer.masksToBounds = true
        //cell.layer.masksToBounds = true
        return cell
    }
    
    struct Connectivity {
      static let sharedInstance = NetworkReachabilityManager()!
      static var isConnectedToInternet:Bool {
          return self.sharedInstance.isReachable
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(articles[indexPath.item].name)
        shopsFetch(name: articles[indexPath.row].name)
        
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
                
        AF.request(url, method: .get, parameters: parameters).responseJSON { (response) in
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
    
}
