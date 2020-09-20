//
//  ArticleListControllerCollectionViewController.swift
//  App
//
//  Created by Kévin CARPAYE on 21/10/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import CoreLocation
import MapKit

private let reuseIdentifier = "Cell"


class SearchArticleController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    let cellID = "cellId"
    let headerId = "headerId"
    let footerId = "footerId"
    
    var shopName = ""

    var articles = [[String: Any]]()
    var article: [SearchArticle]?
    var shops = [[String: Any]]()
    var shop: [SearchShop]?
    var currentLatitude: Float = 0.0
    var currentLongitude: Float = 0.0
    
    var locationManager: CLLocationManager?
    
    private let refreshControl = UIRefreshControl()
    
    let zeroShop : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 160/255, green: 200/255, blue: 221/255, alpha: 0.5)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let zeroShopMessage : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Aucun commerce n'est répertorié pour le moment. Le référencement est en cours."
        label.numberOfLines = 3
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(red: 160/255, green: 200/255, blue: 221/255, alpha: 1)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(SearchShopViewCell.self, forCellWithReuseIdentifier: cellID)
        self.collectionView?.register(SeachShopHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
        DisplayShop()
        //refresh()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        if self.shop?.count == 0 {
            setupMessage()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupMessage() {
        view.addSubview(zeroShop)
        NSLayoutConstraint.activate([
            zeroShop.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zeroShop.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            zeroShop.widthAnchor.constraint(equalToConstant: 320),
            zeroShop.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        zeroShop.addSubview(zeroShopMessage)
        NSLayoutConstraint.activate([
            //zeroShopMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //zeroShopMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //zeroShopMessage.widthAnchor.constraint(equalToConstant: 300)
            zeroShopMessage.topAnchor.constraint(equalTo: zeroShop.topAnchor),
            zeroShopMessage.leftAnchor.constraint(equalTo: zeroShop.leftAnchor),
            zeroShopMessage.rightAnchor.constraint(equalTo: zeroShop.rightAnchor),
            zeroShopMessage.bottomAnchor.constraint(equalTo: zeroShop.bottomAnchor)
            
        ])
    }
    
    private func DisplayShop() {
        
        self.article = [SearchArticle]()
        self.shop = [SearchShop]()
        
        for articleArray in articles as[[String: AnyObject]] {
            let article = SearchArticle()
            article.name = (articleArray["name"] as! String)
            article.image = (articleArray["image"] as! String)
            self.article?.append(article)
        }
        
        var unsorted : [SearchShop] = []
        for dictionary in shops as [[String: AnyObject]] {
            let shop = SearchShop()
            shop.name = (dictionary["name"] as! String) 
            shop.adress = (dictionary["adress"] as! String)
            shop.image = (dictionary["image"] as! String)
            shop.price_base = (dictionary["price_base"] as! Double)
            shop.price = (dictionary["price"] as! Double)
            shop.link = (dictionary["link"] as? String)
            shop.date_start = (dictionary["date_start"] as! String)
            shop.date_end = (dictionary["date_end"] as! String)
            shop.informations = (dictionary["informations"] as! String)
            shop.number = (dictionary["number"] as! String)
            shop.stock = dictionary["stock"] as? Int
            shop.distance = dictionary["distance"] as? Double
            shop.latitude = dictionary["latitude"] as? Float
            shop.longitude = dictionary["longitude"] as? Float
            unsorted.append(shop)
        }
        self.shop = unsorted.sorted(by: {
            Int($0.distance!) < Int($1.distance!)
        })
    }
    
    func refresh() {
        self.collectionView.refreshControl = refreshControl
        refreshControl.tintColor = .black
        refreshControl.attributedTitle = NSAttributedString(string: "Recahrgement des données")
    }
    
    @objc private func refreshDistance() {
        
    }
    
    private func sendAction(name: String, action: String) {
        let url : String = Urls().BASE_URL +  "/analytics"
        let parameter : [String : String] = ["shopName": name,"action" : action]
        AF.request(url, method: .post, parameters: parameter, encoder: JSONParameterEncoder.default).responseJSON { (response) in
            switch response.result {
            case .success:
//                if let data = response.data {
//                    do {
//
//                    }
//                    catch let error as NSError {
//                        print(error)
//                    }
//                }
                break
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
//    func Request() {
//        let url = Urls().BASE_URL + "/listShopSearchWithBarcode"
//        let parameters = ["barcode": self.articleBarcode]
//
//        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: nil).responseJSON { (response) in
//            switch response.result {
//            case .success:
//                if let data = response.data {
//                    do {
//                        print(response.result)
//                        let responseDecoded = try JSONDecoder().decode(ScanArticleStruct.self, from: data)
//
//                        if responseDecoded.request == 0 {
//                            Alert().displayAlert(controller: self, title: "Erreur", message: responseDecoded.result)
//                        }
//
//                        if responseDecoded.request == 1 {
//                            Alert().displayAlert(controller: self, title: "Ajouté", message: responseDecoded.result)
//
//                            //self.navigationController?.popViewController(animated: true)
//                        }
//
//                        print(responseDecoded.result)
//                    }
//                    catch let error as NSError {
//                        print(error)
//                    }
//                }
//                break
//            case .failure (let error):
//                print(error)
//            }
//        }
//    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return shop?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchShopViewCell
        cell.backgroundColor = .white
        cell.shop = shop?[indexPath.item]
        // Configure the cell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SeachShopHeaderCell
            header.backgroundColor = UIColor(red: 25/255, green: 155/255, blue: 222/255, alpha: 0.5)
            header.article = article?[0]
            return header
            } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
            footer.backgroundColor = .green
            return footer
        }
        
    }

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 350, height: 250)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //print(article?[0].image as Any)
        self.shopName = self.shop?[indexPath.item].name! as! String
        let choicdAlert = UIAlertController(title: "", message: "Que faire ?", preferredStyle: .alert)
        
        let addToList = UIAlertAction(title: "Ajouter à la liste", style: .default) { (alert) in
            print("Aller à la liste")
            print((self.shop?[indexPath.item].link)!)
            guard let image = self.article?[0].image else { return }
            guard let name = self.article?[0].name else { return }
            guard let price = self.shop?[indexPath.item].price_base else { return }
            guard let shop = self.shop?[indexPath.item].name else { return }
            print("---------------")
            print(Urls().BASE_URL_IMAGE + image)
//
//            var im: UIImageView = {
//                let image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
//                let im = UIImageView(image: image)
//                im.translatesAutoresizingMaskIntoConstraints = false
//                im.contentMode = .scaleAspectFit
//                return im
//            }()
//
//            im.download(Urls().BASE_URL_IMAGE + image)
//            let data = (im.image)?.pngData()
//            print("----------------")
//            print(data)
            
            CoreDataHelper().saveArticle(name, price: price, shop: shop, image:  image)
            self.sendAction(name: shop, action: "save")
            
        }
        
        let web = UIAlertAction(title: "Voir l'offre", style: .default) { (alert) in
            let site = self.shop![indexPath.item].link!
            if let url = URL(string: "\(site)") {
                UIApplication.shared.open(url)
            }
            self.sendAction(name: self.shop![indexPath.item].name!, action: "site")
        }
        
        let latitude = shop?[indexPath.item].latitude
        let longitude = shop?[indexPath.item].longitude
        let GPS = UIAlertAction(title: "Itinéraire", style: .default) { (alert) in
            print("Afficher le trajet")
            self.GpsChoice(latitde: latitude, longitude: longitude)
            
        }
        
        let close = UIAlertAction(title: "Fermer", style: .destructive, handler: nil)
        
        if (self.shop![indexPath.item].link!.count > 2) {
            print(self.shop![indexPath.item].link!)
            choicdAlert.addAction(web)
        }
        
        choicdAlert.addAction(addToList)
        choicdAlert.addAction(GPS)
        choicdAlert.addAction(close)
        
        self.present(choicdAlert, animated: true, completion: nil)
    }
    
    private func GoogleMaps(latitde: Float?, longitude: Float?) {
        if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(latitde!),\(longitude!)&directionsmode=driving") {
            UIApplication.shared.open(url, options: [:])  // verifier lors des test que l'appel à google map ne plante pas
        }
    }
    
    private func Maps(latitude: Float?, longitude: Float?) {
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude!), longitude: CLLocationDegrees(longitude!))
        let placemark = MKPlacemark(coordinate: location)
        let options = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        let map = MKMapItem(placemark: placemark)
        map.openInMaps(launchOptions: options)
    }
    
    private func GpsChoice(latitde: Float?, longitude: Float?) {
        let alert = UIAlertController(title: "Itinéraire", message: "", preferredStyle: .actionSheet)
        
        let googleMaps = UIAlertAction(title: "Google Maps", style: .default) { (UIAlertAction) in
            self.sendAction(name: self.shopName, action: "route")
            self.GoogleMaps(latitde: latitde, longitude: longitude)
        }
        
        let maps = UIAlertAction(title: "Plans", style: .default) { (UIAlertAction) in
            self.sendAction(name: self.shopName, action: "route")
            self.Maps(latitude: latitde, longitude: longitude)
        }
        
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        alert.addAction(googleMaps)
        alert.addAction(maps)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
