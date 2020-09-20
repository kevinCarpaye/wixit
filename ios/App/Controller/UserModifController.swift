//
//  UserModifController.swift
//  App
//
//  Created by Kévin CARPAYE on 22/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import Alamofire

class UserModifController: UIViewController {
    
    var image: UIImage? = nil
    var user : [User] = []
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var divScrollView: UIView = {
        let div = UIView()
        div.translatesAutoresizingMaskIntoConstraints = false
        div.heightAnchor.constraint(equalToConstant: 800).isActive = true
        return div
    }()
    
    var div: UIView = {
        let div = UIView()
        div.translatesAutoresizingMaskIntoConstraints = false
        div.backgroundColor = .white//UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 0.6)
        return div
    }()
    
    var profilPicture: UIButton = {
        let picture = UIButton()
        let image = UIImage(named: "userB")?.withRenderingMode(.alwaysOriginal)
        picture.setImage(image, for: .normal)
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.contentMode = .scaleAspectFit
        picture.clipsToBounds = true
        picture.layer.cornerRadius = 90
        return picture
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Modifier la photo de profil", for: .normal)
        button.setTitleColor(UIColor(displayP3Red: 0, green: 182/255, blue: 1, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(Picked), for: .touchUpInside)
        return button
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Nom"
        label.textColor = .black
        return label
    }()
    
    var nameTextFiel: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.black.cgColor
        text.textColor = .black
        text.layer.cornerRadius = 5
        return text
    }()
    
    var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.text = "Email"
        emailLabel.textColor = .black
        return emailLabel
    }()
    
    var emailTextfield: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.black.cgColor
        text.textColor = .black
        text.layer.cornerRadius = 5
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
    
    var city: UIPickerView = {
        let city = UIPickerView()
        let color = UIColor.black
        city.setValue(color, forKey: "textColor")
        city.translatesAutoresizingMaskIntoConstraints = false
        
        return city
    }()
    
    var button2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Modifier le mot de passe", for: .normal)
        button.setTitleColor(UIColor(displayP3Red: 0, green: 182/255, blue: 1, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(ChangePassword), for: .touchUpInside)
        return button
    }()
    
    var leftNavButton: UIButton = {
        let button = UIButton()
    
        return button
    }()
    
    var rightNavButton: UIButton = {
        let button = UIButton()
        //button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Terminer", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(InputCheck), for: .touchUpInside)
        return button
    }()
    
    var pickerData: Array = ["L'Ajoupa-Bouillon", "Les Anses-d'Arlet", "Basse-Pointe", "Bellefontaine", "Le Carbet", "Case-Pilote", "Le Diamant", "Ducos", "Fonds-Saint-Denis", "Fort-de-France", "Le François", "Grand'Rivière", "Gros-Morne", "Le Lamentin", "Le Lorrain", "Macouba", "Le Marigot", "Le Marin", "Le Morne-Rouge", "Le Morne-Vert", "Le Prêcheur", "Rivière-Pilote", "Rivière-Salée", "Le Robert", "Sainte-Anne", "Sainte-Luce", "Sainte-Marie", "Saint-Esprit", "Saint-Joseph", "Saint-Pierre", "Schœlcher", "La Trinité", "Les Trois-Îlets", "Le Vauclin"]
    
    var dataSelected: String = ""
    var userName: String = ""
    var email: String = ""
    var searchCity: String = ""
    
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        SetupViews()
        picker.delegate = self
        picker.allowsEditing = false
        SetupTextFieldsInfo()
        SetupCityUser()
        
    }
    
    func SetupViews() {
        updateUser()
        SetupScrollView()
        SetupDivScrollView()
        SetupDiv()
        SetupProfilPicture()
        SetupModifButton()
        SetupNameLabel()
        SetupNameTextField()
        SetupEmailLabel()
        SetupEmailTextField()
        SetupCityLabel()
        SetupCity()
        SetupModifButton2()
        SetupRightNavButton()
        self.tabBarController?.tabBar.isHidden = true
        print(self.searchCity)
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
    
    func SetupDiv() {
        divScrollView.addSubview(div)
        div.topAnchor.constraint(equalTo: divScrollView.topAnchor).isActive = true
        div.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        div.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        div.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        div.heightAnchor.constraint(equalToConstant: 750).isActive = true
    }
    
    func SetupProfilPicture() {
        div.addSubview(profilPicture)
        profilPicture.topAnchor.constraint(equalTo: div.topAnchor, constant: 10).isActive = true
        profilPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilPicture.widthAnchor.constraint(equalToConstant: 180).isActive = true
        profilPicture.heightAnchor.constraint(equalToConstant: 180).isActive = true
        profilPicture.setImage(image, for: .normal)
    }
    
    func SetupModifButton() {
        div.addSubview(button)
        button.topAnchor.constraint(equalTo: profilPicture.bottomAnchor, constant: 10).isActive = true
        button.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        button.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func SetupNameLabel() {
        div.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupNameTextField() {
        div.addSubview(nameTextFiel)
        nameTextFiel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        nameTextFiel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        nameTextFiel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        nameTextFiel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameTextFiel.delegate = self
    }
    
    func SetupEmailLabel() {
        div.addSubview(emailLabel)
        emailLabel.topAnchor.constraint(equalTo: nameTextFiel.bottomAnchor, constant: 10).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupEmailTextField() {
        div.addSubview(emailTextfield)
        emailTextfield.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
        emailTextfield.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        emailTextfield.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        emailTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTextfield.delegate = self
    }
    
    func SetupCityLabel() {
        div.addSubview(cityLabel)
        cityLabel.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 10).isActive = true
        cityLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        cityLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupCity() {
        div.addSubview(city)
        city.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5).isActive = true
        city.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        city.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        city.bottomAnchor.constraint(equalTo: div.bottomAnchor, constant: -80).isActive = true
        city.delegate = self
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
    
    func SetupModifButton2() {
        div.addSubview(button2)
        button2.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 50).isActive = true
        button2.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        button2.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func SetupRightNavButton() {
//        let rightNavBut = UIBarButtonItem(customView: rightNavButton)
//        rightNavBut.style = .plain
//        self.navigationItem.setRightBarButton(rightNavBut, animated: true)
        let add = UIBarButtonItem(title: "Terminé", style: .plain, target: self, action: #selector(InputCheck))
        navigationItem.rightBarButtonItem = add
    }
    
    @objc func Picked() {
        AlertPicker().Choice(controller: self, picker: picker, forUser: true, imageButton: profilPicture)
    }
    
    @objc func ChangePassword() {
        let CPC = ChangePasswordController()
        CPC.email = self.emailTextfield.text!
        self.navigationController?.pushViewController(CPC, animated: true)
    }
    
    func SetupTextFieldsInfo() {
        self.nameTextFiel.text = self.userName
        self.emailTextfield.text = self.email
    }
    
    func SetupCityUser() {
        var currentIndex = 0
        for cityName in pickerData {
            if cityName == searchCity {
//                print("Found \(cityName) à l'index \(currentIndex)")
                dataSelected = cityName
                break
            }
            currentIndex += 1
        }
        city.selectRow(currentIndex, inComponent: 0, animated: true)
    }
    
    @objc func test() {
        
    }
    
    @objc func InputCheck() {
       

//        if nameModified != nameTextFiel.text {
//            nameModified = nameTextFiel.text!
//            print("name modifié")
//        }
//
//        if emailModified != emailTextfield.text {
//            emailModified = emailTextfield.text!
//            print("email modifié")
//        }
//
//        if cityModified != searchCity {
//            cityModified = dataSelected
//            print("ville modifié")
//        }

        if userName == nameTextFiel.text && email == emailTextfield.text && dataSelected == searchCity {
            //let im = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
            if nameTextFiel.text!.count < 3 {
                nameTextFiel.layer.borderColor = UIColor.red.cgColor
                nameTextFiel.shake()
                return
            }
            
            guard let imageData = self.user[0].picture else { return  }
            let picture = UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal)
            if (profilPicture.imageView?.image?.isEqual(picture))! {
                print("identique")
                self.navigationController?.popViewController(animated: true)
                return
                //self.navigationController?.pushViewController(AC, animated: true)
            }
        }
        let validation = isValidEmailAddress(emailAddressString:emailTextfield.text!)
        
        guard validation == true else {
            emailTextfield.shake()
            //messageLabel.text = "L'email est incorrect"
            return
        }
        
        Request()
        //print("\(nameTextFiel.text) \(emailTextfield.text) \(dataSelected)")
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    
    
    func Request() {
        let url = Urls().BASE_URL + "/updateUserProfil"
        let parameters: [String: String] = ["userName": nameTextFiel.text!, "email": emailTextfield.text!, "city": dataSelected, "old": email]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                CoreDataHelper().DeleteUser(self.user[0])
                let image =  self.profilPicture.imageView!.image!.pngData()
                CoreDataHelper().saveUser(self.emailTextfield.text, image: image)
                print("Modifié")
                self.navigationController?.popViewController(animated: true)
                break
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
}


extension UserModifController: UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let original = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                print("OK")
                self.profilPicture.setImage(original, for: .normal)
                self.profilPicture.contentMode = .scaleAspectFit
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dataSelected = pickerData[row]
        print(dataSelected)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nameTextFiel.layer.borderColor = UIColor.black.cgColor
        emailTextfield.layer.borderColor = UIColor.black.cgColor
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
}

