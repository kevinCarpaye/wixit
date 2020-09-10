//
//  User.swift
//  App
//
//  Created by Kévin CARPAYE on 9/9/20.
//  Copyright © 2020 Konex. All rights reserved.
//

import UIKit

class Users {
    
    func updateUser() -> [User]  {
        var userArray: [User] = []
        CoreDataHelper().getUser { (user) in
            //print("Nombre d'utilisateur \(user?.count)")
            if user != nil && user!.count > 0 {
                print("il y a toujours quelqu'un")
                DispatchQueue.main.async {
                    userArray = user!
                    print("Le nombre d'utilisateur : \(userArray.count)")
                    //let imageData = userArray[0].picture
                    //print(imageData)
                    //picture = UIImage(data: imageData!)?.withRenderingMode(.alwaysOriginal)
                    //viewController.profilPicture.setImage(picture, for: .normal)
                }
            }
//            else {
//                print("il n'y a personne")
//                DispatchQueue.main.async {
//                   // let picture = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
//                    //self.profilPicture.setImage(picture, for: .normal)
//                }
//            }
        }
        
        return userArray
    }
    
    
    
    func isConnected() {
        
    }
}
