//
//  ViewController.swift
//  App
//
//  Created by Kévin CARPAYE on 19/10/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var carre: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        setupCarre()
    }
    
    func setupCarre() {
        view.addSubview(carre)
        carre.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        carre.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        carre.widthAnchor.constraint(equalToConstant: 300).isActive = true
        carre.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    struct Connectivity {
      static let sharedInstance = NetworkReachabilityManager()!
      static var isConnectedToInternet:Bool {
          return self.sharedInstance.isReachable
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
