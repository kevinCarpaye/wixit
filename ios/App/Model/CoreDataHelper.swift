//
//  CoreDataHelper.swift
//  App
//
//  Created by Kévin CARPAYE on 06/11/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import CoreData

typealias ArticleCompletion = (_ articles: [ListeArticle]?) -> Void
typealias UserCompletion = (_ user: [User]?) -> Void
typealias PictureCompletion = (_ picture: [ProfilPicture]?) -> Void

class CoreDataHelper {
     
    private let appDel = UIApplication.shared.delegate as! AppDelegate
    
    var context: NSManagedObjectContext {
        return appDel.persistentContainer.viewContext
    }
    
    func save() {
        appDel.saveContext()
    }
    
    func saveArticle(_ name: String?, price: Double?, shop: String?, image: String?) {
        let article = ListeArticle(context: CoreDataHelper().context)
        article.name = name
        article.image = image
        article.price = price ?? 0
        article.shop = shop
        save()
        print("-----------------")
        print("sauvegardé")
    }
    
    func saveUser(_ email: String?, image: Data?) {
        let user = User(context: CoreDataHelper().context)
        user.email = email
        user.picture = image
        save()
        print("-----------------")
        print("sauvegardé")
    }
    
    func savePicture(_ picture: Data?) {
        let pic = ProfilPicture(context: CoreDataHelper().context)
        pic.picture = picture
        save()
        print("-----------------")
        print("sauvegardé")
    }
    
    func getArticles(completion: ArticleCompletion?) {
        let fetchRequest: NSFetchRequest<ListeArticle> = ListeArticle.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "shop", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let articles = try context.fetch(fetchRequest)
            for a in articles {
                print("\(a.name)  \(a.price)  \(a.shop) \(a.image) \(a.status)")
            }
            completion?(articles)
        }
        catch {
            
        }
    }
    
    func getUser(completion: UserCompletion?) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let user = try context.fetch(fetchRequest)
            for a in user {
                print("\(a.email) \(a.picture)")
            }
            completion?(user)
        }
        catch {
            
        }
    }
    
    func getPicture(completion: PictureCompletion?) {
        let fetchRequest: NSFetchRequest<ProfilPicture> = ProfilPicture.fetchRequest()
        do {
            let picture = try context.fetch(fetchRequest)
            for pic in picture {
                print(picture)
            }
            completion?(picture)
        }
        catch {
            
        }
    }
    
    func UpdateArticleStatus(_ article: ListeArticle, newValue: Bool) {
        do {
            article.setValue(newValue, forKey: "status")
            do {
                try context.save()
            }
            catch {
                print(error.localizedDescription)
            }
        }
        catch {
            print(error)
        }
        
        print(article.status)
    }
    
    func DeleteArticle(_ article: ListeArticle) {
        context.delete(article)
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func DeleteUser(_ user: User) {
        context.delete(user)
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func DeletePicture(_ picture: ProfilPicture) {
        context.delete(picture)
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

