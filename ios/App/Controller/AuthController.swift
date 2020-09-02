//
//  AuthController.swift
//  App
//
//  Created by Kévin CARPAYE on 03/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

class AuthController: UIViewController {
    
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
        // Do any additional setup after loading the view.
//        self.navigationController.pushViewController(nextViewController, animated: true)
    }
    
    func SetupView() {
        SetupConnectionButton()
        SetupInscriptionButton()
    }
    
    func SetupConnectionButton() {
        view.addSubview(ConnectionButton)
        ConnectionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        ConnectionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        ConnectionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90).isActive = true
        ConnectionButton.heightAnchor.constraint(equalToConstant: 40).isActive =  true
    }
    
    func SetupInscriptionButton() {
        view.addSubview(RegisterButton)
        RegisterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        RegisterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        RegisterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        RegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func GoToConnection() {
        let conn = LoginController()
        self.navigationController?.pushViewController(conn, animated: true)
    }
    
    @objc func GoToRegister() {
        let reg = RegisterController()
        self.navigationController?.pushViewController(reg, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
