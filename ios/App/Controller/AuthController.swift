//
//  AuthController.swift
//  App
//
//  Created by Kévin CARPAYE on 03/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

class AuthController: UIViewController {
    
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
    
    var ConnectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Connexion", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 0, green: 182/255, blue: 1, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(GoToConnection), for: .touchUpInside)
        return button
    }()
    
    var RegisterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Inscription", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 0, green: 182/255, blue: 1, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(GoToRegister), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SetupView()
        self.tabBarController?.tabBar.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchedCross))
        crossIcon.addGestureRecognizer(tap)
        crossIcon.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
//        self.navigationController.pushViewController(nextViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func SetupView() {
        setupCrossView()
        setupCrossIcon()
        SetupConnectionButton()
        SetupInscriptionButton()
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
    
    func SetupConnectionButton() {
        view.addSubview(ConnectionButton)
        ConnectionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        ConnectionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        ConnectionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -110).isActive = true
        ConnectionButton.heightAnchor.constraint(equalToConstant: 50).isActive =  true
    }
    
    func SetupInscriptionButton() {
        view.addSubview(RegisterButton)
        RegisterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        RegisterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        RegisterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        RegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func touchedCross() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func GoToConnection() {
        let conn = LoginController()
        self.navigationController?.pushViewController(conn, animated: false)
    }
    
    @objc func GoToRegister() {
        let reg = RegisterController()
        self.navigationController?.pushViewController(reg, animated: true)
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
    // }
}
