//
//  ViewController.swift
//  App
//
//  Created by Kévin CARPAYE on 02/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController {
    
    var email: String = "test@gmail.com"
    var password: String = "test123"
    var picture: [ProfilPicture] = []
    var pic: Data? = nil
    
    
    var div: UIView = {
        let div = UIView()
        div.translatesAutoresizingMaskIntoConstraints = false
        //div.backgroundColor = UIColor(displayP3Red: 150/255, green: 150/255, blue: 150/255, alpha: 0.2)
        return div
    }()
    
    var messageLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .red
        label.textAlignment = .center
        label.textColor = .red
        return label
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Identifiant"
        label.textColor = .black
        return label
    }()
    
    var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.layer.borderWidth = 2
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.textColor = .black
        return textField
    }()
    
    var userPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Mot de passe"
        label.textColor = .black
        return label
    }()
    
    var userPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        return textField
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Connexion", for: .normal)
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(displayP3Red: 0, green: 182/255, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(checkInputs), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        updatePicture()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.navigationItem.title = "Se connecter"
        
        SetupDiv()
        
        SetupMessageLabel()
        SetupUsernameLabel()
        SetupUsernameTextField()
        SetupUserPasswordLabel()
        SetupUserPasswordTextfield()
        setupButton()
        self.tabBarController?.tabBar.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func SetupDiv () {
        view.addSubview(div)
        div.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        div.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        div.widthAnchor.constraint(equalToConstant: 300).isActive = true
        div.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func SetupMessageLabel() {
        view.addSubview(messageLabel)
        messageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: div.topAnchor, constant: -10).isActive =  true
        messageLabel.heightAnchor.constraint(equalToConstant: 40).isActive =  true
    }
    
    func SetupUsernameLabel() {
        div.addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: div.topAnchor, constant: 20).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupUsernameTextField() {
        div.addSubview(userNameTextField)
        userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5).isActive = true
        userNameTextField.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        userNameTextField.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        userNameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        userNameTextField.delegate = self
        userNameTextField.underlined()
    }
    
    func SetupUserPasswordLabel() {
        div.addSubview(userPasswordLabel)
        userPasswordLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20).isActive = true
        userPasswordLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        userPasswordLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        userPasswordLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupUserPasswordTextfield() {
        div.addSubview(userPasswordTextField)
        userPasswordTextField.topAnchor.constraint(equalTo: userPasswordLabel.bottomAnchor, constant:5).isActive = true
        userPasswordTextField.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        userPasswordTextField.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        userPasswordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        userPasswordTextField.delegate = self
    }
    
    func setupButton() {
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func updatePicture() {
        CoreDataHelper().getPicture { (picture) in
            if picture != nil && picture?.count != 0 {
                DispatchQueue.main.async {
                    print(picture?.count)
                    self.pic = picture?[0].picture
                }
            }
        }
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
    
    @objc func HideKeyboard() {
        view.endEditing(true)
        print("touched")
    }
    
    @objc func checkInputs() {
        
        let validation = isValidEmailAddress(emailAddressString: userNameTextField.text!)
        
        guard validation == true else {
            userNameTextField.layer.borderColor = UIColor.red.cgColor
            messageLabel.text = "L'email est incorrect"
            return
        }
        
        guard userPasswordTextField.text!.count > 3 else {
            userPasswordTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        Request()
        
    }
    
    func Request() {
        
//        if userNameTextField.text == self.email && userPasswordTextField.text == self.password {
//            // Fonction pour changer la vue
//            self.messageLabel.text = ""
//
//        }
//        else {
//            guard userNameTextField.text == self.email else {
//                self.messageLabel.text = "Email inconnu"
//                self.userNameTextField.layer.borderColor = UIColor.red.cgColor
//                return
//            }
//
//            guard userPasswordTextField.text == self.password else {
//                self.messageLabel.text = "Mot de passe incorrect"
//                self.userPasswordTextField.layer.borderColor = UIColor.red.cgColor
//                return
//            }
//        }
        
        let url: String = Urls().BASE_URL + "/login"
        let parameters: [String: String] = ["email": userNameTextField.text!, "password": userPasswordTextField.text!]
        
        AF.request(url, method: .get, parameters: parameters, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let responseDecoded = try JSONDecoder().decode(UserLoginStruct.self, from: data)
                        if responseDecoded.request == 1 {
                            if self.messageLabel.text != "" {
                                self.messageLabel.text = ""
                            }
//                            let dfn = (UIImage(named: "promo")?.withRenderingMode(.alwaysOriginal))!
//                            let picture = dfn.jpegData(compressionQuality: 1);
                            
                            if self.pic != nil {
                                CoreDataHelper().saveUser(self.userNameTextField.text!, image: self.pic)
                            }
                            else {
                                let image = UIImage(named: "noPicture")?.withRenderingMode(.alwaysOriginal)
                                let pic = image?.pngData()
                                CoreDataHelper().saveUser(self.userNameTextField.text!, image: pic)
                                if self.picture.count > 0 {
                                CoreDataHelper().DeletePicture(self.picture[0])
                                }
                            }
                        
                            self.navigationController?.pushViewController(ScanController(), animated: true)
                            print("ghjklmù")
                        }
                        else {
                            self.messageLabel.text = responseDecoded.result
                        }
                        
                        print(responseDecoded.result)
                        
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
}



extension LoginController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if userNameTextField.text!.count < 3 {
            userNameTextField.layer.borderColor = UIColor.red.cgColor
        }

        else {
            userNameTextField.layer.borderColor = UIColor.green.cgColor
        }

        if userPasswordTextField.text!.count < 3 {
            userPasswordTextField.layer.borderColor = UIColor.red.cgColor
        }
        else {
            userPasswordTextField.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if userNameTextField.text!.count < 3 {
            userNameTextField.layer.borderColor = UIColor.red.cgColor
        }

        else {
            userNameTextField.layer.borderColor = UIColor.green.cgColor
        }
        
        let validate = isValidEmailAddress(emailAddressString: userNameTextField.text!)
        if validate != true {
            userNameTextField.layer.borderColor = UIColor.red.cgColor
        }
        else {
            userNameTextField.layer.borderColor = UIColor.green.cgColor
        }

        if userPasswordTextField.text!.count < 3 {
            userPasswordTextField.layer.borderColor = UIColor.red.cgColor
        }

        else  {
            userPasswordTextField.layer.borderColor = UIColor.green.cgColor
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
}

