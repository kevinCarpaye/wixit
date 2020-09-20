//
//  RegisterController.swift
//  App
//
//  Created by Kévin CARPAYE on 02/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    var crossView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var crossIcon : UIImageView = {
        var image = UIImage(named: "cross")?.withRenderingMode(.alwaysOriginal)
        var imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    let registerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        text.layer.cornerRadius = 5
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.black.cgColor
        let placeholderText = NSAttributedString(string: " Nom", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 0.3)])
        text.attributedPlaceholder = placeholderText
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
        text.layer.cornerRadius = 5
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.black.cgColor
        let placeholderText = NSAttributedString(string: " email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 0.3)])
        text.attributedPlaceholder = placeholderText
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
        text.layer.cornerRadius = 5
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.black.cgColor
        let placeholderText = NSAttributedString(string: " Mot de passe", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 0.3)])
        text.attributedPlaceholder = placeholderText
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
        text.layer.cornerRadius = 5
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.black.cgColor
        let placeholderText = NSAttributedString(string: " Confirmation Mot de passe", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 0.3)])
        text.attributedPlaceholder = placeholderText
        text.textColor = .black
        return text
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continuer", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(displayP3Red: 0, green: 182/255, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(checkInputs), for: .touchUpInside)
        return button
    }()
    
    var moveLogoAnimator : UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        self.navigationItem.title = "Inscription"
        SetupObjects()
        self.tabBarController?.tabBar.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(HideKeyboard))
        view.addGestureRecognizer(tap)
        
        let tappedCross = UITapGestureRecognizer(target: self, action: #selector(touchedCross))
        crossIcon.addGestureRecognizer(tappedCross)
        crossIcon.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseOut, animations: {
            self.registerView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (success) in
            self.setupMoveLogoAnimation()
            self.moveLogoAnimator.startAnimation()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        registerView.layer.cornerRadius = CGFloat(7)
        button.layer.cornerRadius = CGFloat(5)
        //image.layer.cornerRadius = CGFloat(50)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseOut) {
//            self.registerView.transform = CGAffineTransform(scaleX: 1, y: 1)
//        } completion: { (success) in
//            self.setupMoveLogoAnimation()
//            self.moveLogoAnimator.startAnimation()
//        }
    }
    
    func SetupObjects () {
        setupCrossView()
        setupCrossIcon()
        setupRegisterView()
        SetupButton()
        SetupCpasswordTextfield()
        SetupPasswordTextfield()
        SetupEmailTextField()
        SetupnameTextfield()
    }
    
    func setupCrossView() {
        view.addSubview(crossView)
        NSLayoutConstraint.activate([
            crossView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            crossView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            crossView.widthAnchor.constraint(equalToConstant: 45),
            crossView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setupCrossIcon() {
        crossView.addSubview(crossIcon)
        NSLayoutConstraint.activate([
            crossIcon.topAnchor.constraint(equalTo: crossView.topAnchor),
            crossIcon.bottomAnchor.constraint(equalTo: crossView.bottomAnchor),
            crossIcon.leftAnchor.constraint(equalTo: crossView.leftAnchor),
            crossIcon.rightAnchor.constraint(equalTo: crossView.rightAnchor)
        ])
    }
    
    func setupRegisterView () {
        view.addSubview(registerView)
        NSLayoutConstraint.activate([
            registerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            registerView.widthAnchor.constraint(equalToConstant: 320),
            registerView.heightAnchor.constraint(equalToConstant: 450)
        ])
        registerView.transform = CGAffineTransform(scaleX: 0, y: 0)
        registerView.backgroundColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
    }
    
//    func SetupMessageLabel() {
//        view.addSubview(messageLabel)
//        messageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
//        messageLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
//        messageLabel.bottomAnchor.constraint(equalTo: div.topAnchor).isActive =  true
//        messageLabel.heightAnchor.constraint(equalToConstant: 40).isActive =  true
//    }
    
//    func SetupNameLabel() {
//        div.addSubview(nameLabel)
//        nameLabel.topAnchor.constraint(equalTo: div.topAnchor).isActive = true
//        nameLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
//        nameLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
//    }
    
    func SetupnameTextfield() {
        registerView.addSubview(nameTextFiel)
        nameTextFiel.bottomAnchor.constraint(equalTo: emailTextfield.topAnchor, constant: -40).isActive = true
        nameTextFiel.leftAnchor.constraint(equalTo: registerView.leftAnchor, constant: 20).isActive = true
        nameTextFiel.rightAnchor.constraint(equalTo: registerView.rightAnchor, constant: -20).isActive = true
        nameTextFiel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameTextFiel.delegate = self
        nameTextFiel.alpha = 0
    }
    
//    func SetupEmailLabel() {
//        div.addSubview(emailLabel)
//        emailLabel.topAnchor.constraint(equalTo: nameTextFiel.bottomAnchor, constant: 10).isActive = true
//        emailLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
//        emailLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
//        emailLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
//    }
    
    func SetupEmailTextField() {
        registerView.addSubview(emailTextfield)
        emailTextfield.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -40).isActive = true
        emailTextfield.leftAnchor.constraint(equalTo: registerView.leftAnchor, constant: 20).isActive = true
        emailTextfield.rightAnchor.constraint(equalTo: registerView.rightAnchor, constant: -20).isActive = true
        emailTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTextfield.delegate = self
        emailTextfield.alpha = 0
    }
    
//    func SetupPasswordLabel() {
//        div.addSubview(passwordLabel)
//        passwordLabel.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 10).isActive = true
//        passwordLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
//        passwordLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
//        passwordLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
//    }
    
    func SetupPasswordTextfield() {
        registerView.addSubview(passwordTextField)
        passwordTextField.bottomAnchor.constraint(equalTo: CpasswordTextField.topAnchor, constant: -40).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: registerView.leftAnchor, constant: 20).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: registerView.rightAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.delegate = self
        passwordTextField.alpha = 0
    }
    
//    func SetupCpasswordLabel() {
//        div.addSubview(CpasswordLabel)
//        CpasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
//        CpasswordLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
//        CpasswordLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
//        CpasswordLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
//    }
    
    func SetupCpasswordTextfield() {
        registerView.addSubview(CpasswordTextField)
        CpasswordTextField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -40).isActive = true
        CpasswordTextField.leftAnchor.constraint(equalTo: registerView.leftAnchor, constant: 20).isActive = true
        CpasswordTextField.rightAnchor.constraint(equalTo: registerView.rightAnchor, constant: -20).isActive = true
        CpasswordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        CpasswordTextField.delegate = self
        CpasswordTextField.alpha = 0
    }
    
    func SetupButton() {
        registerView.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: registerView.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: registerView.bottomAnchor, constant: -50),
            button.widthAnchor.constraint(equalToConstant: 280),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
        button.alpha = 0
    }
    
    @objc func touchedCross() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupMoveLogoAnimation() {
        moveLogoAnimator = UIViewPropertyAnimator(duration: 2.0, curve: .easeIn, animations: nil)
        moveLogoAnimator.addAnimations({
            //self.image.frame.origin.y = 20
            self.registerView.backgroundColor = .white
        }, delayFactor: 1)
     
        moveLogoAnimator.addAnimations({
            self.nameTextFiel.alpha = 1
        }, delayFactor: 0.5)
        
        moveLogoAnimator.addAnimations({
            self.emailTextfield.alpha = 1
        }, delayFactor: 0.6)
        
        moveLogoAnimator.addAnimations({
            self.passwordTextField.alpha = 1
        }, delayFactor: 0.7)
        
        moveLogoAnimator.addAnimations({
            self.CpasswordTextField.alpha = 1
        }, delayFactor: 0.8)
        
        moveLogoAnimator.addAnimations({
            self.button.alpha = 1
        }, delayFactor: 0.9)
    }
    
    @objc func checkInputs() {
        
        guard nameTextFiel.text!.count >= 3 else {
            nameTextFiel.layer.borderColor = UIColor.red.cgColor
            nameTextFiel.shake()
            //messageLabel.text = "Le format du nom est incorrect"
            return
        }
        
        let validation = isValidEmailAddress(emailAddressString: emailTextfield.text!)
        
        guard validation == true else {
            emailTextfield.layer.borderColor = UIColor.red.cgColor
            emailTextfield.shake()
            //messageLabel.text = "L'email est incorrect"
            return
        }
        
        
        guard passwordTextField.text!.count >= 3 else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.shake()
            //messageLabel.text = "Le mot de passe n'est pas conforme"
            return
        }
        
        print("1")
        guard CpasswordTextField.text == passwordTextField.text  else {
            CpasswordTextField.layer.borderColor = UIColor.red.cgColor
            CpasswordTextField.shake()
            //messageLabel.text = "Les mots de passe ne correspondent pas"
            return
        }
        print("2")
        Request()
        
    }
    
    func Request() {
        
        // Fonction pour changer la vue
        print("3")
        self.messageLabel.text = ""
        let R2C = Register2Controller()
        R2C.name = nameTextFiel.text!
        R2C.email = emailTextfield.text!
        R2C.password = passwordTextField.text!
        R2C.Cpassword = CpasswordTextField.text!
        self.navigationController?.pushViewController(R2C, animated: false)
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
    }
}


extension RegisterController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        nameTextFiel.layer.borderColor = UIColor.black.cgColor
        emailTextfield.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        CpasswordTextField.layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if nameTextFiel.text!.count < 3 {
//            nameTextFiel.layer.borderColor = UIColor.red.cgColor
//        }
//        else {
//            nameTextFiel.layer.borderColor = UIColor.green.cgColor
//        }
//
//        let validate = isValidEmailAddress(emailAddressString: emailTextfield.text!)
//        if validate != true {
//            emailTextfield.layer.borderColor = UIColor.red.cgColor
//        }
//        else {
//            emailTextfield.layer.borderColor = UIColor.green.cgColor
//        }
//
//        if passwordTextField.text!.count < 3 {
//            passwordTextField.layer.borderColor = UIColor.red.cgColor
//        }
//        else {
//            passwordTextField.layer.borderColor = UIColor.green.cgColor
//        }
//
//        if CpasswordTextField.text != passwordTextField.text {
//            CpasswordTextField.layer.borderColor = UIColor.red.cgColor
//        }
//        else {
//            CpasswordTextField.layer.borderColor = UIColor.green.cgColor
//        }
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
}

