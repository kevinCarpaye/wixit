//
//  ChangePasswordController.swift
//  App
//
//  Created by Kévin CARPAYE on 25/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import Alamofire

class ChangePasswordController: UIViewController {
    
    var div: UIView = {
        let div = UIView()
        div.translatesAutoresizingMaskIntoConstraints = false
        div.backgroundColor = UIColor(displayP3Red: 150/255, green: 150/255, blue: 150/255, alpha: 0.2)
        return div
    }()
    
    var messageLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .red
        label.textAlignment = .center
        return label
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
        button.setTitle("Modifier", for: .normal)
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(CheckInputs), for: .touchUpInside)
        return button
    }()
    
    var email: String = ""
    
    let BASE_URL = Urls().BASE_URL

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        SetupViews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(HideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func SetupViews() {
        SetupDiv()
        SetupMessageLabel()
        SetupPasswordLabel()
        SetupPasswordTextfield()
        SetupCpasswordLabel()
        SetupCpasswordTextfield()
        setupButton()
        self.tabBarController?.tabBar.isHidden = true
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
    
    func SetupPasswordLabel() {
        div.addSubview(passwordLabel)
        passwordLabel.topAnchor.constraint(equalTo: div.topAnchor, constant: 20).isActive = true
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
    
    func setupButton() {
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func CheckInputs() {
        
        guard passwordTextField.text!.count > 3 else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            messageLabel.text = "Le mot de passe doit contenir au moins 4 caractères"
            return
        }
        
        guard CpasswordTextField.text == passwordTextField.text else {
            CpasswordTextField.layer.borderColor = UIColor.red.cgColor
            messageLabel.text = "Les mots de passe ne correspondent pas"
            return
        }
        
        messageLabel.text = ""
        Requests()
    }
    
    func Requests() {
        
        let url: String = BASE_URL + "/updatePassword"
        let parameters = ["email": self.email, "password": self.passwordTextField.text!, "Cpassword": self.CpasswordTextField.text!]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(_):
                if let data = response.data {
                    do {
                        let responseDecoded = try JSONDecoder().decode(ChangePassword.self, from: data)
                        if responseDecoded.request == 1 {
                            AlertChecked().Message(title: "Réussi", message: responseDecoded.result, controller: self)
                        }
                        if responseDecoded.request == 0 {
                            AlertChecked().Message(title: "Erreur", message: responseDecoded.result, controller: self)
                        }
                    }
                    catch let error as NSError {
                        AlertChecked().Message(title: "Erreur", message: "Les serveurs sont indisponibles, veuillez réessayer ultérieurement", controller: self)
                    }
                }
                break
            case .failure(let error):
                AlertChecked().Message(title: "Erreur", message: "Les serveurs sont indisponibles, veuillez réessayer ultérieurement", controller: self)
            }
        }
    }
    
    @objc func HideKeyboard() {
        view.endEditing(true)
    }

}


extension ChangePasswordController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if passwordTextField.text!.count < 3 {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
        }
        else {
            passwordTextField.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
