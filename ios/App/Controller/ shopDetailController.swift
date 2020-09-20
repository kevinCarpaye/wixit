//
//  ShopDetailController.swift
//  App
//
//  Created by Kevin on 04/01/2020.
//  Copyright © 2020 Konex. All rights reserved.
//

import UIKit
import MapKit

class ShopDetailController: UIViewController {
    
    let profilPicture:UIButton = {
        let image = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        return button
    }()
    
//    let shopImageView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .red
//        return view
//    }()
    
    let shopImage: UIImageView = {
        let image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        let imageview = UIImageView(image: image)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .white
        return tableview
    }()
    
    let nameCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
    }()
    
    let nameText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.text = "----------------"
        return label
    }()
    
    let shopLogo: UIImageView = {
        let image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        let imageview = UIImageView(image: image)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    
    let numberCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
    }()
    
    let numberImage: UIImageView = {
        let image = UIImage(named: "phone")?.withRenderingMode(.alwaysOriginal)
        let imageview = UIImageView(image: image)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    let numberText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.text = "----------------"
        return label
    }()
    
    let adressCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
    }()
    
    let adressImage: UIImageView = {
        let image = UIImage(named: "map-1")?.withRenderingMode(.alwaysOriginal)
        let imageview = UIImageView(image: image)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    let adressText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.text = "-------------"
        label.numberOfLines = 3
        return label
    }()
    
    let informationsCell: UITableViewCell = {
        let label = UITableViewCell()
        label.backgroundColor = .white
        label.selectionStyle = .none
        return label
    }()
    
    let informationsText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.text = "---------------"
        label.numberOfLines = 0;
        return label
    }()
    
    let informationsImage: UIImageView = {
        let image = UIImage(named: "info")?.withRenderingMode(.alwaysOriginal)
        let imageview = UIImageView(image: image)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    let mapkitCell : UITableViewCell = {
        let mapkit = UITableViewCell()
        mapkit.backgroundColor = .white
        mapkit.selectionStyle = .none
        return mapkit
    }()
    
    let mapview : MKMapView = {
        let mapview = MKMapView()
        mapview.translatesAutoresizingMaskIntoConstraints = false
        mapview.mapType = .standard
        mapview.isZoomEnabled = true
        mapview.isScrollEnabled = false
        return mapview
    }()
    
    var kTableHeaderHeight:CGFloat = 300.0
       
    var name: String = ""
    var number: String? = "0000000000"
    var adress: String = ""
    var informations: String? = ""
    var latitude: Float = 0.0
    var longitude: Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SetupViews()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        //self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    private func SetupViews() {
        SetupNavigationBar()
        setupLeftNavButton()
        SetupImageView()
        SetupTableView()
        SetupNameCell()
        SetupNumberCell()
        SetupAdressCell()
        SetupInformationsCell()
        SetupMapKit()
        SetupAnnotation()
    }
    
    private func SetupNavigationBar() {
        self.navigationItem.title = "Détails"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    func setupLeftNavButton() {
        let image = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //imageView.clipsToBounds = true
        //imageView.layer.cornerRadius = (imageView.frame.size.width / 2)
        //profilPicture.setBackgroundImage(profilPicture.imageView?.image, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func SetupImageView() {
        view.addSubview(shopImage)
        NSLayoutConstraint.activate([
            shopImage.topAnchor.constraint(equalTo: view.topAnchor),
            shopImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            shopImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            shopImage.heightAnchor.constraint(equalToConstant: view.frame.size.height / 3),
//             shopImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func SetupTableView() {
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: shopImage.bottomAnchor, constant: 10),
            tableview.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableview.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
//        tableview.frame = CGRect(x: 0, y: 300, width: view.frame.width, height: 500)
//        tableview.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
//        tableview.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        
    }
    
    private func SetupNameCell() {
        
        nameCell.addSubview(nameText)
        NSLayoutConstraint.activate([
            nameText.centerYAnchor.constraint(equalTo: nameCell.centerYAnchor),
            nameText.leftAnchor.constraint(equalTo: nameCell.leftAnchor, constant: 20),
            //nameText.widthAnchor.constraint(equalToConstant: 200),
            nameText.heightAnchor.constraint(equalToConstant: 30)
        ])
        nameText.text = name
        
        nameCell.addSubview(shopLogo)
        NSLayoutConstraint.activate([
            shopLogo.centerYAnchor.constraint(equalTo: nameCell.centerYAnchor),
            shopLogo.rightAnchor.constraint(equalTo: nameCell.rightAnchor, constant: -20),
            shopLogo.widthAnchor.constraint(equalToConstant: 50),
            shopLogo.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func SetupNumberCell() {
        
        numberCell.addSubview(numberImage)
        NSLayoutConstraint.activate([
            numberImage.centerYAnchor.constraint(equalTo: numberCell.centerYAnchor),
            numberImage.leftAnchor.constraint(equalTo: numberCell.leftAnchor, constant: 15),
            numberImage.widthAnchor.constraint(equalToConstant: 30),
            numberImage.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        numberCell.addSubview(numberText)
        NSLayoutConstraint.activate([
            numberText.centerYAnchor.constraint(equalTo: numberCell.centerYAnchor),
            numberText.leftAnchor.constraint(equalTo: numberImage.rightAnchor, constant: 20),
            numberText.rightAnchor.constraint(equalTo: numberCell.rightAnchor, constant: -20),
            numberText.heightAnchor.constraint(equalToConstant: 30)
        ])
        numberText.text = number
    }
    
    private func SetupAdressCell() {
        
        adressCell.addSubview(adressImage)
        NSLayoutConstraint.activate([
            adressImage.centerYAnchor.constraint(equalTo: adressCell.centerYAnchor),
            adressImage.leftAnchor.constraint(equalTo: adressCell.leftAnchor, constant: 15),
            adressImage.widthAnchor.constraint(equalToConstant: 30),
            adressImage.heightAnchor.constraint(equalToConstant: 30)
        ])
        adressCell.addSubview(adressText)
        NSLayoutConstraint.activate([
            adressText.centerYAnchor.constraint(equalTo: adressCell.centerYAnchor),
            adressText.leftAnchor.constraint(equalTo: adressImage.rightAnchor, constant: 20),
            adressText.rightAnchor.constraint(equalTo: adressCell.rightAnchor, constant: -20),
            
        ])
        adressText.text = adress
    }
    
    private func SetupInformationsCell() {
        informationsCell.addSubview(informationsImage)
        if informations != "" {
            NSLayoutConstraint.activate([
                informationsImage.topAnchor.constraint(equalTo: informationsCell.topAnchor, constant: 10),
                informationsImage.leftAnchor.constraint(equalTo: informationsCell.leftAnchor, constant: 15),
                informationsImage.widthAnchor.constraint(equalToConstant: 30),
                informationsImage.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
        else {
            NSLayoutConstraint.activate([
                //informationsImage.centerYAnchor.constraint(equalTo: informationsCell.centerYAnchor),
                informationsImage.leftAnchor.constraint(equalTo: informationsCell.leftAnchor, constant: 15),
                informationsImage.widthAnchor.constraint(equalToConstant: 30),
                informationsImage.heightAnchor.constraint(equalToConstant: 30),
                informationsCell.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
        
        informationsCell.addSubview(informationsText)
        NSLayoutConstraint.activate([
            //informationsText.centerYAnchor.constraint(equalTo: informationsCell.centerYAnchor),
            informationsText.topAnchor.constraint(equalTo: informationsCell.topAnchor, constant: 10),
            informationsText.bottomAnchor.constraint(equalTo: informationsCell.bottomAnchor),
            informationsText.leftAnchor.constraint(equalTo: informationsImage.rightAnchor, constant: 20),
            informationsText.rightAnchor.constraint(equalTo: informationsCell.rightAnchor, constant: -20)
            
        ])
        informationsText.text = self.informations
    }
    
    private func SetupMapKit() {
        mapkitCell.addSubview(mapview)
        NSLayoutConstraint.activate([
            mapview.topAnchor.constraint(equalTo: mapkitCell.topAnchor, constant: 10),
            mapview.leftAnchor.constraint(equalTo: mapkitCell.leftAnchor, constant: 20),
            mapview.rightAnchor.constraint(equalTo: mapkitCell.rightAnchor, constant: -20),
            mapview.heightAnchor.constraint(equalToConstant: 250),
//            mapview.centerXAnchor.constraint(equalTo: mapkitCell.centerXAnchor),
//            mapview.centerYAnchor.constraint(equalTo: mapkitCell.centerYAnchor)
            
            mapview.bottomAnchor.constraint(equalTo: mapkitCell.bottomAnchor)
        ])
        mapview.delegate = self
    }
    
    private func SetupAnnotation() {
        
        let anno = MKPointAnnotation()
        anno.title = self.name
        anno.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(self.latitude), longitude: CLLocationDegrees(self.longitude))
        mapview.addAnnotation(anno)
        mapview.centerCoordinate = anno.coordinate
        centreMap()
        
    }
    
    private func centreMap(){
        let location = CLLocation(latitude: CLLocationDegrees(self.latitude), longitude: CLLocationDegrees(self.longitude))
        let region_radious = 1000
        let region = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: CLLocationDistance(region_radious), longitudinalMeters: CLLocationDistance(region_radious))
        mapview.setRegion(region, animated: true)
          
    }
    
    private func makeCall(phone: String) {
        if let phoneCallURL = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(phoneCallURL)
        {
            UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
        }
    }
    
    private func GoogleMaps() {
        if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    private func Maps() {
        let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        let placemark = MKPlacemark(coordinate: location)
        let options = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        let map = MKMapItem(placemark: placemark)
        map.openInMaps(launchOptions: options)
    }
    
    private func GpsChoice() {
        let alert = UIAlertController(title: "Itinéraire", message: "", preferredStyle: .actionSheet)
        
        let googleMaps = UIAlertAction(title: "Google Maps", style: .default) { (UIAlertAction) in
            self.GoogleMaps()
        }
        
        let maps = UIAlertAction(title: "Plans", style: .default) { (UIAlertAction) in
            self.Maps()
        }
        
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        alert.addAction(googleMaps)
        alert.addAction(maps)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 60), 400)
        //shopImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        print("scrollé")
    }

}


extension ShopDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section)
        {
        case 0:  return 1;  // section 0 has 2 rows
        case 1:  return 1;  // section 1 has 1 row
        case 2:  return 1;
        case 3:  return 1;
        case 4:  return 1;
        default: return 0;
        };
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
                case 0: return self.nameCell  // section 0, row 0 is the first name
            //case 1: return self.lastNameCell    // section 0, row 1 is the last name
                default: fatalError("Unknown row in section 0")
            }
        case 1:
            switch(indexPath.row) {
                case 0: return self.numberCell     // section 1, row 0 is the share option
                default: fatalError("Unknown row in section 1")
            }
        case 2:
            switch(indexPath.row) {
                case 0: return self.adressCell
                default: fatalError("Unknown row in section 2")
            }
        case 3:
            switch indexPath.row {
                case 0: return self.informationsCell
                default: fatalError("Unknown row in section 3")
            }
        case 4:
            switch indexPath.row {
                case 0: return self.mapkitCell
                default: fatalError("Unknown row in section 4")
            }
        default: fatalError("Unknown section")
        }
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//        header.addSubview(shopImage)
//        return header
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 3 || indexPath.section == 4) {
               return UITableView.automaticDimension
           }
        else {
            return 50
           }
//        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        if indexPath.section == 1 {
            makeCall(phone: self.number!)
        }
        if indexPath.section == 4 {
            GpsChoice()
        }
    }
    
}

extension ShopDetailController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
    
}
