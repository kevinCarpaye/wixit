//
//  RegisterController.swift
//  App
//
//  Created by Kévin CARPAYE on 02/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    var messageLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .red
        label.textAlignment = .center
        label.textColor = .red
        return label
    }()
    
    var div: UIView = {
        let div = UIView()
        div.translatesAutoresizingMaskIntoConstraints = false
//        div.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 0.6)
        return div
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
        text.layer.borderWidth = 2
        text.layer.borderColor = UIColor.black.cgColor
        text.textColor = .black
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
        text.layer.borderWidth = 2
        text.layer.borderColor = UIColor.black.cgColor
        text.textColor = .black
        return text
    }()
    
    var passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Mot de passe"
        label.textColor = .black
        return label
    }()
    
    var passwordTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isSecureTextEntry = true
        text.layer.borderWidth = 2
        text.layer.borderColor = UIColor.black.cgColor
        text.textColor = .black
        return text
    }()
    
    var CpasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Confirmation Mot de passe"
        label.textColor = .black
        return label
    }()
    
    var CpasswordTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isSecureTextEntry = true
        text.layer.borderWidth = 2
        text.layer.borderColor = UIColor.black.cgColor
        text.textColor = .black
        return text
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continuer", for: .normal)
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(displayP3Red: 0, green: 182/255, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(checkInputs), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Inscription"
        SetupObjects()
        self.tabBarController?.tabBar.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(HideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func SetupObjects () {
        SetupDiv()
        SetupMessageLabel()
        SetupNameLabel()
        SetupNameTextField()
        SetupEmailLabel()
        SetupEmailTextField()
        SetupPasswordLabel()
        SetupPasswordTextfield()
        SetupCpasswordLabel()
        SetupCpasswordTextfield()
        SetupButton()
    }
    
    func SetupMessageLabel() {
        view.addSubview(messageLabel)
        messageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: div.topAnchor).isActive =  true
        messageLabel.heightAnchor.constraint(equalToConstant: 40).isActive =  true
    }
    
    func SetupDiv() {
        view.addSubview(div)
        div.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        div.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        div.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        div.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        div.heightAnchor.constraint(equalToConstant: 380).isActive = true
    }
    
    func SetupNameLabel() {
        div.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: div.topAnchor).isActive = true
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
    
    func SetupPasswordLabel() {
        div.addSubview(passwordLabel)
        passwordLabel.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 10).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupPasswordTextfield() {
        div.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.delegate = self
    }
    
    func SetupCpasswordLabel() {
        div.addSubview(CpasswordLabel)
        CpasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        CpasswordLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        CpasswordLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        CpasswordLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupCpasswordTextfield() {
        div.addSubview(CpasswordTextField)
        CpasswordTextField.topAnchor.constraint(equalTo: CpasswordLabel.bottomAnchor, constant: 5).isActive = true
        CpasswordTextField.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        CpasswordTextField.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        CpasswordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        CpasswordTextField.delegate = self
    }
    
    func SetupButton() {
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func checkInputs() {
        
        guard nameTextFiel.text!.count >= 3 else {
            nameTextFiel.layer.borderColor = UIColor.red.cgColor
            messageLabel.text = "Le format du nom est incorrect"
            return
        }
        
        let validation = isValidEmailAddress(emailAddressString: emailTextfield.text!)
        
        guard validation == true else {
            emailTextfield.layer.borderColor = UIColor.red.cgColor
            messageLabel.text = "L'email est incorrect"
            return
        }
        
        
        guard passwordTextField.text!.count >= 3 else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            messageLabel.text = "Le mot de passe n'est pas conforme"
            return
        }
        
        guard CpasswordTextField.text == passwordTextField.text else {
            CpasswordTextField.layer.borderColor = UIColor.red.cgColor
            messageLabel.text = "Les mots de passe ne correspondent pas"
            return
        }

        Request()
        
    }
    
    func Request() {
        
        // Fonction pour changer la vue
        self.messageLabel.text = ""
        let R2C = Register2Controller()
        R2C.name = nameTextFiel.text!
        R2C.email = emailTextfield.text!
        R2C.password = passwordTextField.text!
        R2C.Cpassword = CpasswordTextField.text!
        self.navigationController?.pushViewController(R2C, animated: true)
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
    
    @objc func buttonClicked() {
        print("Le boutton à été enfoncé")
    }
    
    @objc func HideKeyboard() {
        view.endEditing(true)
    }
}


extension RegisterController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if nameTextFiel.text!.count < 3 {
            nameTextFiel.layer.borderColor = UIColor.red.cgColor
        }
        else {
            nameTextFiel.layer.borderColor = UIColor.green.cgColor
        }
        
        if passwordTextField.text!.count < 3 {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
        }
        else {
            passwordTextField.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if nameTextFiel.text!.count < 3 {
            nameTextFiel.layer.borderColor = UIColor.red.cgColor
        }
        else {
            nameTextFiel.layer.borderColor = UIColor.green.cgColor
        }
        
        let validate = isValidEmailAddress(emailAddressString: emailTextfield.text!)
        if validate != true {
            emailTextfield.layer.borderColor = UIColor.red.cgColor
        }
        else {
            emailTextfield.layer.borderColor = UIColor.green.cgColor
        }
        
        if passwordTextField.text!.count < 3 {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
        }
        else {
            passwordTextField.layer.borderColor = UIColor.green.cgColor
        }
        
        if CpasswordTextField.text != passwordTextField.text {
            CpasswordTextField.layer.borderColor = UIColor.red.cgColor
        }
        else {
            CpasswordTextField.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

