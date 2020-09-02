//
//  UserInfoController.swift
//  App
//
//  Created by Kévin CARPAYE on 19/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserInfoController: UIViewController {
    
    var user: [User] = []
    
    var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var divScrollView: UIView = {
        let div = UIView()
        div.translatesAutoresizingMaskIntoConstraints = false
        div.heightAnchor.constraint(equalToConstant: 700).isActive = true
        return div
    }()
    
    var div1: UIView = {
        let div = UIView()
        div.translatesAutoresizingMaskIntoConstraints = false
        div.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 0.6)
        return div
    }()
    
    var profilPicture: UIButton = {
        let picture = UIButton()
        let image = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
        picture.setImage(image, for: .normal)
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.contentMode = .scaleAspectFit
//      picture.addTarget(self, action: #selector(picked), for: .touchUpInside)
        picture.clipsToBounds = true
        picture.layer.cornerRadius = 50
        return picture
    }()
    
    var searchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        //label.text = "Nom"
        return label
    }()
    
    var ScanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        //label.text = "Code Barre"
        return label
    }()
    
    var IALabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        //label.text = "IA"
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        return label
    }()
    
    var numberOfSearch: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        return label
    }()
    
    var numberOfScan: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        return label
    }()
    
    var numberIASearch: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        //label.text = "Indisp"
        return label
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Modifier le profil", for: .normal)
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(red: 25/255, green: 155/255, blue: 222/255, alpha: 0.5)
        button.addTarget(self, action: #selector(GoToModifController), for: .touchUpInside)
        return button
    }()
    
    var select: UISegmentedControl = {
        let items: [String] = ["Informations","Dernières recherches"]
        let select = UISegmentedControl(items: items)
        select.translatesAutoresizingMaskIntoConstraints = false
        select.selectedSegmentIndex = 0
        select.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
       return select
    }()
    
    var divInfo: UIView = {
        let div = UIView()
        div.translatesAutoresizingMaskIntoConstraints = false
        div.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 0.6)
        return div
    }()
    
    var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.text = "Email"
        emailLabel.textColor = .black
        return emailLabel
    }()
    
    var emailTextfield: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 16)
        text.text = ""
        text.textColor = .gray
        return text
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Ville"
        label.textColor = .black
        return label
    }()
    
    var city: UILabel = {
        let city = UILabel()
        city.translatesAutoresizingMaskIntoConstraints = false
        city.font = UIFont.systemFont(ofSize: 16)
        city.text = ""
        city.textColor = .gray
        return city
    }()
    
    var logout: UIButton = {
        var label = UIButton(type: .system)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setTitle("Se déconnecter", for: .normal)
        label.setTitleColor(UIColor.red, for: .normal)
        label.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        label.addTarget(self, action: #selector(Logout), for: .touchUpInside)
        return label
    }()
    
    var registerDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Date d'incription"
        label.textColor = .black
        return label
    }()
    
    var registerDateTextField: UILabel = {
        let textfield = UILabel()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = UIFont.systemFont(ofSize: 15)
        textfield.text = ""
        textfield.textColor = .gray
        return textfield
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        updateUser()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.Requests()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SetupViews()
    }
    
    func SetupViews () {
        SetupScrollView()
        SetupDivScrollView()
        SetupDiv1()
        SetupProfilPicture()
        SetupName()
        //SetupSearch()
        //SetupScan()
        //SetupIA()
        SetupModifButton()
        //SetupSelect()
        SetupDivInfo()
        SetupEmailLabel()
        SetupEmailTextField()
        SetupCityLabel()
        SetupCity()
        SetupLogoutButton()
        SetupRegisterDateLabel()
        SetupRegisterDateTextField()
        SetupTableView()
        self.tabBarController?.tabBar.isHidden = true
        self.tableView.isHidden = true
    }
    
    func SetupScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func SetupDivScrollView() {
        scrollView.addSubview(divScrollView)
        divScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        divScrollView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        divScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func SetupDiv1() {
        divScrollView.addSubview(div1)
        div1.topAnchor.constraint(equalTo: divScrollView.topAnchor).isActive = true
        div1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        div1.widthAnchor.constraint(equalToConstant: 320).isActive = true
        div1.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func SetupProfilPicture() {
        div1.addSubview(profilPicture)
        profilPicture.topAnchor.constraint(equalTo: div1.topAnchor, constant: 20).isActive = true
        profilPicture.leftAnchor.constraint(equalTo: div1.leftAnchor, constant: 10).isActive = true
        profilPicture.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profilPicture.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func SetupName() {
        div1.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: div1.topAnchor, constant: 60).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: profilPicture.rightAnchor, constant: 30).isActive = true
    }
    
    func SetupSearch() {
        div1.addSubview(searchLabel)
        searchLabel.topAnchor.constraint(equalTo: profilPicture.bottomAnchor, constant: 40).isActive = true
        searchLabel.leftAnchor.constraint(equalTo: div1.leftAnchor, constant: 20 ).isActive = true
//        searchLabel.centerXAnchor.constraint(equalTo: div1.frame.width / 3).isActive = true
        searchLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        searchLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        div1.addSubview(numberOfSearch)
        numberOfSearch.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 10).isActive = true
        numberOfSearch.leftAnchor.constraint(equalTo: div1.leftAnchor, constant: 20).isActive = true
        numberOfSearch.widthAnchor.constraint(equalToConstant: 50).isActive = true
        numberOfSearch.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func SetupScan() {
        div1.addSubview(ScanLabel)
        ScanLabel.topAnchor.constraint(equalTo: profilPicture.bottomAnchor, constant: 40).isActive = true
        ScanLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ScanLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        ScanLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        div1.addSubview(numberOfScan)
        numberOfScan.topAnchor.constraint(equalTo: ScanLabel.bottomAnchor, constant: 10).isActive = true
        numberOfScan.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive  = true
        numberOfScan.widthAnchor.constraint(equalToConstant: 50).isActive = true
        numberOfScan.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func SetupIA() {
        div1.addSubview(IALabel)
        IALabel.topAnchor.constraint(equalTo: profilPicture.bottomAnchor, constant: 40).isActive = true
        IALabel.rightAnchor.constraint(equalTo: div1.rightAnchor, constant: -20).isActive = true
        IALabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        IALabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        div1.addSubview(numberIASearch)
        numberIASearch.topAnchor.constraint(equalTo: ScanLabel.bottomAnchor, constant: 10).isActive = true
        numberIASearch.rightAnchor.constraint(equalTo: div1.rightAnchor, constant: -20).isActive = true
        numberIASearch.widthAnchor.constraint(equalToConstant: 50).isActive = true
        numberIASearch.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func SetupModifButton() {
        div1.addSubview(button)
        button.topAnchor.constraint(equalTo: profilPicture.bottomAnchor, constant: 20).isActive = true
        button.leftAnchor.constraint(equalTo: div1.leftAnchor, constant: 20).isActive = true
        button.rightAnchor.constraint(equalTo: div1.rightAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.isEnabled = false
    }
    
    func SetupSelect() {
        div1.addSubview(select)
        select.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30).isActive = true
        select.leftAnchor.constraint(equalTo: div1.leftAnchor, constant: 20).isActive = true
        select.rightAnchor.constraint(equalTo: div1.rightAnchor, constant: -20).isActive = true
        select.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func SetupDivInfo() {
        divScrollView.addSubview(divInfo)
        divInfo.topAnchor.constraint(equalTo: div1.bottomAnchor, constant: 10).isActive = true
        divInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        divInfo.widthAnchor.constraint(equalToConstant: 320).isActive = true
        divInfo.heightAnchor.constraint(equalToConstant: 280).isActive = true
    }
    
    func SetupEmailLabel() {
        divInfo.addSubview(emailLabel)
        emailLabel.topAnchor.constraint(equalTo: divInfo.topAnchor).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: divInfo.leftAnchor, constant: 20).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: divInfo.rightAnchor, constant: -20).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupEmailTextField() {
        divInfo.addSubview(emailTextfield)
        emailTextfield.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
        emailTextfield.leftAnchor.constraint(equalTo: divInfo.leftAnchor, constant: 20).isActive = true
        emailTextfield.rightAnchor.constraint(equalTo: divInfo.rightAnchor, constant: -20).isActive = true
        emailTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupCityLabel() {
        divInfo.addSubview(cityLabel)
        cityLabel.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 10).isActive = true
        cityLabel.leftAnchor.constraint(equalTo: divInfo.leftAnchor, constant: 20).isActive = true
        cityLabel.rightAnchor.constraint(equalTo: divInfo.rightAnchor, constant: -20).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupCity() {
        divInfo.addSubview(city)
        city.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5).isActive = true
        city.leftAnchor.constraint(equalTo: divInfo.leftAnchor, constant: 20).isActive = true
        city.rightAnchor.constraint(equalTo: divInfo.rightAnchor, constant: -20).isActive = true
        city.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupLogoutButton() {
        view.addSubview(logout)
        NSLayoutConstraint.activate([
            logout.topAnchor.constraint(equalTo: divInfo.bottomAnchor, constant: 10),
            logout.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logout.widthAnchor.constraint(equalToConstant: 150),
            logout.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func SetupRegisterDateLabel() {
        divInfo.addSubview(registerDateLabel)
        registerDateLabel.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 10).isActive = true
        registerDateLabel.leftAnchor.constraint(equalTo: divInfo.leftAnchor, constant: 20).isActive = true
        registerDateLabel.rightAnchor.constraint(equalTo: divInfo.rightAnchor, constant: -20).isActive = true
        registerDateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupRegisterDateTextField() {
        divInfo.addSubview(registerDateTextField)
        registerDateTextField.topAnchor.constraint(equalTo: registerDateLabel.bottomAnchor, constant: 5).isActive = true
        registerDateTextField.leftAnchor.constraint(equalTo: divInfo.leftAnchor, constant: 20).isActive = true
        registerDateTextField.rightAnchor.constraint(equalTo: divInfo.rightAnchor, constant: -20).isActive = true
        registerDateTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: div1.bottomAnchor, constant: 10).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 280).isActive = true
    }
    
    func updateUser() {
        CoreDataHelper().getUser { (user) in
            if user != nil && user!.count > 0 {
                DispatchQueue.main.async {
                    self.user = user!
                    print("Le nombre d'utilisateur : \(self.user.count)")
                    print("L'email de l'utilisateur : \(self.user[0].email)")
                    let imageData = self.user[0].picture
                    let picture = UIImage(data: imageData!)?.withRenderingMode(.alwaysOriginal)
                    self.profilPicture.setImage(picture, for: .normal)
                }
            }
        }
    }
    
    func Requests() {
        let url = Urls().BASE_URL + "getUserProfil/"
        let email = self.user[0].email
        let parameters = ["email": email]
        AF.request(url, method: .get, parameters: parameters, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let responseDecoded = try JSONDecoder().decode(GetUserProfilStruct.self, from: data)
                        print(responseDecoded)
                        self.nameLabel.text = responseDecoded.response.userName
                        self.emailTextfield.text = responseDecoded.response.email
                        self.city.text = responseDecoded.response.city
                        self.ChangeDateFormat(date: responseDecoded.response.createdAt)
                        self.button.isEnabled = true
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
    
    func ChangeDateFormat(date : String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let newFormat = DateFormatter()
        newFormat.dateFormat = "dd/MM/yyyy"
        if let newDate = formatter.date(from: date) {
            let trueDate = newFormat.string(from: newDate)
            self.registerDateTextField.text = trueDate
        }
    }
    
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            divInfo.isHidden = false
            tableView.isHidden = true
            break
        case 1:
            divInfo.isHidden = true
            tableView.isHidden = false
            break
        default:
            break
        }
    }
    
    @objc func Logout() {
        CoreDataHelper().DeleteUser(user[0])
        self.navigationController?.pushViewController(ScanController(), animated: true)
    }
    
    @objc func GoToModifController() {
        let UMC = UserModifController()
        UMC.image = self.profilPicture.imageView?.image
        UMC.userName = self.nameLabel.text!
        UMC.email = self.emailTextfield.text!
        UMC.searchCity = self.city.text!
        self.navigationController?.pushViewController(UMC, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

}

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}
