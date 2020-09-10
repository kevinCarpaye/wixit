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
    
    let loginView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var image : UIImageView = {
        let image = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
        let imageview = UIImageView(image: image)
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.layer.masksToBounds = true
        return imageview
    }()
    
    let usernameTextfield : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.cornerRadius = 5
        let placeholderText = NSAttributedString(string: " Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 0.3)])
        text.attributedPlaceholder = placeholderText
        text.textColor = .black
        return text
    }()
    
    var passwordTextfield: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 5
        let placeholderText = NSAttributedString(string: " Mot de passe", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 0.3)])
        textField.attributedPlaceholder = placeholderText
        textField.textColor = .black
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Connexion", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(displayP3Red: 0, green: 182/255, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(checkInputs), for: .touchUpInside)
        return button
    }()
    
    var moveLogoAnimator : UIViewPropertyAnimator!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: true)
        updatePicture()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        self.navigationItem.title = "Se connecter"
        setupCrossView()
        setupCrossIcon()
        setupLoginView()
        setupImage()
        setupLoginButton()
        setupPasswordTextfield()
        setupUsernameTextfield()
    
        self.tabBarController?.tabBar.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HideKeyboard))
        view.addGestureRecognizer(tap)
        
        let tapCross = UITapGestureRecognizer(target: self, action: #selector(touchedCross))
        crossIcon.addGestureRecognizer(tapCross)
        crossIcon.isUserInteractionEnabled = true
        
//        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseOut) {
//            self.loginView.transform = CGAffineTransform(scaleX: 1, y: 1)
//        } completion: { (success) in
//            self.setupMoveLogoAnimation()
//            self.moveLogoAnimator.startAnimation()
//        }
        
        UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseOut, animations: {
            self.loginView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (success) in
            self.setupMoveLogoAnimation()
            self.moveLogoAnimator.startAnimation()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginView.layer.cornerRadius = CGFloat(7)
        loginButton.layer.cornerRadius = CGFloat(5)
        image.layer.cornerRadius = CGFloat(50)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
    
    func setupLoginView () {
        view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.widthAnchor.constraint(equalToConstant: 320),
            loginView.heightAnchor.constraint(equalToConstant: 420)
        ])
        loginView.transform = CGAffineTransform(scaleX: 0, y: 0)
        loginView.backgroundColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
    }
    
    func setupImage() {
        loginView.addSubview(image)
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: loginView.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupUsernameTextfield() {
        loginView.addSubview(usernameTextfield)
        NSLayoutConstraint.activate([
            usernameTextfield.bottomAnchor.constraint(equalTo: passwordTextfield.topAnchor, constant: -40),
            usernameTextfield.leftAnchor.constraint(equalTo: loginView.leftAnchor, constant: 20),
            usernameTextfield.rightAnchor.constraint(equalTo: loginView.rightAnchor, constant: -20),
            usernameTextfield.heightAnchor.constraint(equalToConstant: 40)
        ])
        usernameTextfield.alpha = 0
        usernameTextfield.delegate = self
    }
    
    func setupPasswordTextfield() {
        loginView.addSubview(passwordTextfield)
        NSLayoutConstraint.activate([
            passwordTextfield.bottomAnchor.constraint(equalTo: loginButton.topAnchor,constant: -40 ),
            passwordTextfield.leftAnchor.constraint(equalTo: loginView.leftAnchor, constant: 20),
            passwordTextfield.rightAnchor.constraint(equalTo: loginView.rightAnchor, constant: -20),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 40)
        ])
        passwordTextfield.alpha = 0
        passwordTextfield.delegate = self
    }
    
    func setupLoginButton() {
        loginView.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -50),
            loginButton.widthAnchor.constraint(equalToConstant: 280),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        loginButton.alpha = 0
    }
    
    func setupMoveLogoAnimation() {
        moveLogoAnimator = UIViewPropertyAnimator(duration: 2.0, curve: .easeIn, animations: nil)
        moveLogoAnimator.addAnimations({
            self.image.frame.origin.y = 20
            self.loginView.backgroundColor = .white
        }, delayFactor: 0.2)
     
        moveLogoAnimator.addAnimations({
            self.usernameTextfield.alpha = 1
        }, delayFactor: 0.5)
        
        moveLogoAnimator.addAnimations({
            self.passwordTextfield.alpha = 1
        }, delayFactor: 0.7)
        
        moveLogoAnimator.addAnimations({
            self.loginButton.alpha = 1
        }, delayFactor: 0.9)
    }
    
    @objc func touchedCross() {
        self.navigationController?.popViewController(animated: true)
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
        
        let validation = isValidEmailAddress(emailAddressString: usernameTextfield.text!)
        
        guard validation == true else {
            usernameTextfield.shake()
            //messageLabel.text = "L'email est incorrect"
            return
        }
        
        guard passwordTextfield.text!.count > 3 else {
            passwordTextfield.shake()
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
        let parameters: [String: String] = ["email": usernameTextfield.text!, "password": passwordTextfield.text!]
        
        AF.request(url, method: .get, parameters: parameters, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let responseDecoded = try JSONDecoder().decode(UserLoginStruct.self, from: data)
                        if responseDecoded.request == 1 {
                            //if self.messageLabel.text != "" {
                                //self.messageLabel.text = ""
                            //}
//                            let dfn = (UIImage(named: "promo")?.withRenderingMode(.alwaysOriginal))!
//                            let picture = dfn.jpegData(compressionQuality: 1);
                            
                            if self.pic != nil {
                                CoreDataHelper().saveUser(self.usernameTextfield.text!, image: self.pic)
                            }
                            else {
                                let image = UIImage(named: "noPicture")?.withRenderingMode(.alwaysOriginal)
                                let pic = image?.pngData()
                                CoreDataHelper().saveUser(self.usernameTextfield.text!, image: pic)
                                if self.picture.count > 0 {
                                CoreDataHelper().DeletePicture(self.picture[0])
                                }
                            }
                        
                            self.navigationController?.pushViewController(HomeControllerViewController(), animated: true)
                        }
                        else {
                            Alert().displayAlert(controller: self, title: "", message: responseDecoded.result)
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
//        if usernameTextfield.text!.count < 3 {
//            usernameTextfield.layer.borderColor = UIColor.red.cgColor
//        }
//
//        if passwordTextfield.text!.count < 3 {
//            passwordTextfield.layer.borderColor = UIColor.red.cgColor
//        }
        
        usernameTextfield.layer.borderColor = UIColor.black.cgColor
        passwordTextfield.layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if usernameTextfield.text!.count < 3 {
//            usernameTextfield.layer.borderColor = UIColor.red.cgColor
//        }
//
//        else {
//            usernameTextfield.layer.borderColor = UIColor.green.cgColor
//        }
//
//        let validate = isValidEmailAddress(emailAddressString: usernameTextfield.text!)
//        if validate != true {
//            usernameTextfield.layer.borderColor = UIColor.red.cgColor
//        }
//        else {
//            usernameTextfield.layer.borderColor = UIColor.green.cgColor
//        }
//
//        if passwordTextfield.text!.count < 3 {
//            passwordTextfield.layer.borderColor = UIColor.red.cgColor
//        }
//
//        else  {
//            passwordTextfield.layer.borderColor = UIColor.green.cgColor
//        }
        
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
    
}

