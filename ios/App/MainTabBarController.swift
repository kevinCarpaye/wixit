//
//  MainTabBarController.swift
//  App
//
//  Created by Kévin CARPAYE on 08/11/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
//    private var nbNotif: Int = 0
//
//    var notif: Int {
//        get {
//            return nbNotif
//        }
//        set {
//            nbNotif = newValue
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTabBar()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBar.barTintColor = .white
//        setListBadge()
    }
    
//    func getNbNotif() -> Int {
//        return nbNotif
//    }
//
//    func setNbNotif(newValue: Int) {
//        nbNotif = newValue
//    }
    
    func setupTabBar() {
        
        let navigationBarAppearace = UINavigationBar.appearance()

        navigationBarAppearace.tintColor = .black
        navigationBarAppearace.barTintColor = .white
     
        UITabBar.appearance().tintColor = UIColor(red: 25/255, green: 155/255, blue: 222/255, alpha: 0.5)
        
//        let scanController = UINavigationController(rootViewController: ScanController())
//        scanController.tabBarItem.image = UIImage(named: "scan")
        let homeController = UINavigationController(rootViewController: HomeControllerViewController())
        homeController.tabBarItem.image = UIImage(named: "search")
        
        let nameController = UINavigationController(rootViewController: NameController())
        nameController.tabBarItem.image = UIImage(named: "")
        
//        let scanControlle = ScanController()
//        scanControlle.tabBarItem.image = UIImage(named: "scan")
        
        let listController = UINavigationController(rootViewController: ListController())
        listController.tabBarItem.image = UIImage(named: "nameSearch2")
        
        let shopController = UINavigationController(rootViewController: ListShopController())
        shopController.tabBarItem.image = UIImage(named: "shop")
        
        let menuController = UINavigationController(rootViewController: MenuController())
        menuController.tabBarItem.image = UIImage(named: "other")
        
        viewControllers = [homeController, listController, shopController, menuController]
        
    }
    
//    func setListBadge() {
//        if (nbNotif > 0) {
//            let listController = UINavigationController(rootViewController: ListController())
//            listController.tabBarItem.badgeValue = "\(nbNotif)"
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//extension UINavigationController {
//   open override var preferredStatusBarStyle: UIStatusBarStyle {
//    return topViewController?.preferredStatusBarStyle ?? .darkContent
//   }
//}
