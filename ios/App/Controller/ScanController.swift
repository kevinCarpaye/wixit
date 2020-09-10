//
//  ScanController.swift
//  App
//
//  Created by Kévin CARPAYE on 28/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import AVFoundation
import UIKit
import Alamofire
import CoreLocation

class ScanController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, CLLocationManagerDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation? = nil
    
    var user: [User] = []
    var distances: [Double] = []
    var merge: [Any] = []
    
    let profilPicture:UIButton = {
        let image = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        return button
    }()
    
    let SquareView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
//    var profilPicture: UIButton = {
//        let image = UIImage(named: "userB")?.withRenderingMode(.alwaysOriginal)
//        let picture = UIButton(type: .system)
//        picture.setImage(image, for: .normal)
//        picture.translatesAutoresizingMaskIntoConstraints = false
//        picture.contentMode = .scaleAspectFit
//        picture.clipsToBounds = true
//        picture.layer.cornerRadius = 20
//        picture.addTarget(self, action: #selector(test), for: .touchUpInside)
//        return picture
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View reload")
        if Connectivity.isConnectedToInternet {
             print("Connected")
         } else {
             Alert().displayAlert(controller: self, title: "Problème de connexion", message: "Veuillez vérifier votre accès internet")
        }
        
        view.backgroundColor = UIColor.black
        self.setupNavigationBar()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
//        found(code: "5026555417006")
        captureSession = AVCaptureSession()
        //found(code: "5026555417006")
        //let infoImage = UIImage(named: "")
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean13]
        } else {
            failed()
            return
        }
        
        
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
//        NSLayoutConstraint.activate([
//            self.SquareView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
//            self.SquareView.heightAnchor.constraint(equalToConstant: 100),
//            self.SquareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            self.SquareView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//        view.bringSubviewToFront(SquareView)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
//        SetupPP()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(named: "noPicture"),
//            style: .plain,
//            target: self,
//            action: #selector(test)
//        )
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scan non disponible", message: "Votre appareil ne supporte pas le scan de code. S'il vous plait utiliser un appreil avec caméra", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.viewDidLoad()
        //SetupRightNavButton()
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
        //self.tabBarController?.tabBar.isHidden = false
        //updateUser()
//        let dfn = (UIImage(named: "promo")?.withRenderingMode(.alwaysOriginal))!
//        let picture = dfn.jpegData(compressionQuality: 1);
//        CoreDataHelper().saveUser("Arthur", email: "arthur@gmail.com", image: picture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
      navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Scanner"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        dismiss(animated: true)
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
    
    @objc func test() {
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
    
    func updateUser() {
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
    
//    func UserPictureCheck(image: UIImage?) -> String {
//       //let im = UIImage(named: "promo")?.withRenderingMode(.alwaysOriginal)
//        if (profilPicture.imageView?.image?.isEqual(image))! {
//            print("identique-----------")
//            return "Identique"
//        }
//        else {
//            print("diffétent------------")
//            return "Différent"
//        }
//    }
    
    func found(code: String) {
        //print(code)
        self.captureSession.stopRunning()
        let url =  Urls().BASE_URL + "searchArticleWithBarcode/"
        var email = ""
        if user.count > 0 {
            email = self.user[0].email ?? ""
        }
            let parameters = ["barcode" : code, "email": email]
        
        AF.request(url, method: .get, parameters: parameters, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let responseDecoded = try JSONDecoder().decode(GetArticleWithCBStuct.self, from: data)
                        if responseDecoded.request == 1 {
                            print("enregistré")
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
                            let alert = UIAlertController(title: "Attention", message: "L'article n'est pas présent dans la base de données, souhaitez-vous l'ajouter ?", preferredStyle: .alert)
                            
                            let yes = UIAlertAction(title: "Oui", style: .default) { (action) in
                                let AAC = AddArticleController()
                                AAC.barcode = code
                                self.navigationController?.pushViewController(AAC, animated: true)
                            }
                            
                            let no = UIAlertAction(title: "Non", style: .destructive, handler: { (action) in
                                self.captureSession.startRunning()
                            })
                            
                            alert.addAction(yes)
                            alert.addAction(no)
                            self.present(alert, animated: true, completion: nil)
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
                Alert().displayAlert(controller: self, title: "Erreur interne", message: "Veuillez réessayer ultérieurement")
                self.captureSession.startRunning()
            }
            print(code)
        }
    }
    
    func Distance(latitude: Float, longitude: Float) -> Double {
        
        let userLocation = CLLocation(latitude: (self.currentLocation?.coordinate.latitude ?? 0.0), longitude: (self.currentLocation?.coordinate.longitude ?? 0.0))
        print("La latitude: \(latitude), la longitude \(longitude)")
        let shopLocation = CLLocation(latitude: CLLocationDegrees(exactly: latitude) ?? 0.0, longitude: CLLocationDegrees(exactly: longitude) ?? 0.0)
        
        let distance = shopLocation.distance(from: userLocation)
        let distanceInKm = distance / 1000
        print("Ce magasin est à \(String(format: "%.2f", distance))m de distance")
        print("Ce magasin est à \(String(format: "%.2f", distanceInKm))m de distance")
        print("Le nombre de distances dans le tableau \(self.distances.count)")
        self.distances.append(distance)
        
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
        captureSession?.startRunning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    struct Connectivity {
      static let sharedInstance = NetworkReachabilityManager()!
      static var isConnectedToInternet:Bool {
          return self.sharedInstance.isReachable
        }
    }
}

