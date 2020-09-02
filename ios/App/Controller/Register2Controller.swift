//
//  Register2Controller.swift
//  App
//
//  Created by Kévin CARPAYE on 02/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Register2Controller: UIViewController {
    
    var div: UIView = {
        let div = UIView()
        div.translatesAutoresizingMaskIntoConstraints = false
//        div.backgroundColor = UIColor.init(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 0.4)
        return div
    }()
    
    var profilPictureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Photo de profil"
        label.textColor = .black
        
        return label
    }()
    
    var profilPicture: UIButton = {
        let picture = UIButton()
        let image = UIImage(named: "userB")?.withRenderingMode(.alwaysOriginal)
        picture.setImage(image, for: .normal)
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.contentMode = .scaleAspectFill
        picture.addTarget(self, action: #selector(picked), for: .touchUpInside)
        picture.clipsToBounds = true
        picture.layer.cornerRadius = 90
        return picture
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Ville"
        label.textColor = .black
        return label
    }()
    
    var city: UIPickerView = {
        let city = UIPickerView()
        city.translatesAutoresizingMaskIntoConstraints = false
        city.setValue(UIColor.black, forKey: "textColor")
        return city
    }()
    
    var pickerData: Array = ["L'Ajoupa-Bouillon", "Les Anses-d'Arlet", "Basse-Pointe", "Bellefontaine", "Le Carbet", "Case-Pilote", "Le Diamant", "Ducos", "Fonds-Saint-Denis", "Fort-de-France", "Le François", "Grand'Rivière", "Gros-Morne", "Le Lamentin", "Le Lorrain", "Macouba", "Le Marigot", "Le Marin", "Le Morne-Rouge", "Le Morne-Vert", "Le Prêcheur", "Rivière-Pilote", "Rivière-Salée", "Le Robert", "Sainte-Anne", "Sainte-Luce", "Sainte-Marie", "Saint-Esprit", "Saint-Joseph", "Saint-Pierre", "Schœlcher", "La Trinité", "Les Trois-Îlets", "Le Vauclin"]
    
    var dataSelected: String = ""
    
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("S'incrire", for: .normal)
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(displayP3Red: 0, green: 182/255, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(Register), for: .touchUpInside)
        return button
    }()
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var Cpassword: String = ""
    
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Incription"
        picker.delegate = self
        picker.allowsEditing = false
        SetupViews()
    }
    
    func SetupViews() {
        
        SetupDiv()
        SetupProfilLabel()
        SetupProfilPicture()
        SetupCityLabel()
        SetupCity()
        setupButton()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func SetupDiv() {
        view.addSubview(div)
        div.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        div.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        div.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        div.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        div.heightAnchor.constraint(equalToConstant: 420).isActive = true
    }
    
    func SetupProfilLabel() {
        div.addSubview(profilPictureLabel)
        profilPictureLabel.topAnchor.constraint(equalTo: div.topAnchor, constant: 10).isActive = true
        profilPictureLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        profilPictureLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        profilPictureLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupProfilPicture() {
        div.addSubview(profilPicture)
        profilPicture.topAnchor.constraint(equalTo: profilPictureLabel.bottomAnchor, constant: 5).isActive = true
        profilPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilPicture.widthAnchor.constraint(equalToConstant: 180).isActive = true
        profilPicture.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
    }
    
    func SetupCityLabel() {
        div.addSubview(cityLabel)
        cityLabel.topAnchor.constraint(equalTo: profilPicture.bottomAnchor, constant: 10).isActive = true
        cityLabel.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        cityLabel.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func SetupCity() {
        div.addSubview(city)
        city.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5).isActive = true
        city.leftAnchor.constraint(equalTo: div.leftAnchor, constant: 20).isActive = true
        city.rightAnchor.constraint(equalTo: div.rightAnchor, constant: -20).isActive = true
        city.bottomAnchor.constraint(equalTo: div.bottomAnchor, constant: -5).isActive = true
        city.delegate = self
    }
    
    func setupButton() {
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func Register() {
        print("Le boutton à été enfoncé")

        let image1 = profilPicture.imageView?.image
        let image2 = UIImage(named: "userB")?.withRenderingMode(.alwaysOriginal)
        if image1 != nil && image1!.isEqual(image2) {

        }
        else {

        }
        RequestWithoutProfilPicture()
    }
    
    @objc func picked() {
       
        
        AlertPicker().Choice(controller: self, picker: picker, forUser: true, imageButton: profilPicture)
        
    }
    
    func RequestWithProfilPicture() {
        let url = Urls().BASE_URL + "registerWithProfilPicture/"
        let parameters = ["username": self.name, "email": self.email, "password": self.password, "Cpassword": self.Cpassword, "city": self.dataSelected]
        print(self.name + " " + self.email + " " + self.password + " " + self.dataSelected)
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
//            .validate(statusCode: 200..<300)
//            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
            switch response.result {
            case .success:
                print(response)
                break
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func RequestWithoutProfilPicture() {
        let url = Urls().BASE_URL + "registerWithoutProfilPicture/"
        let parameters = ["username": self.name, "email": self.email, "password": self.password, "Cpassword": self.Cpassword, "city": self.dataSelected]
        print(self.name + " " + self.email + " " + self.password + " " + self.dataSelected)
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            //            .validate(statusCode: 200..<300)
            //            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
            switch response.result {
            case .success:
                //print(response)
                if let data = response.data {
                    do {
                        let responseDecoded = try JSONDecoder().decode(UserRegisterStruct.self, from: data)
                        if responseDecoded.request == 1 {
                            //let image = self.profilPicture.imageView!.image!.jpegData(compressionQuality: 1);
                            let image =  self.profilPicture.imageView!.image!.pngData()
                            CoreDataHelper().savePicture(image)
                            Alert().displayAlert(controller: self, title: "Compte crée", message: "Vous êtes dirigés vers la page de connxion")
                            self.navigationController?.pushViewController(LoginController(), animated: true)
                        }
                        else {
                            Alert().displayAlert(controller: self, title: "Erreur", message: responseDecoded.result)
                        }
                    }
                    catch let error as NSError {
                        print(error)
                        Alert().displayAlert(controller: self, title: "Erreur Interne", message: "Veuillez essayer ultérieurement") 
                    }
                }
                break
                    
            case .failure(let error):
                print(error)
                Alert().displayAlert(controller: self, title: "Erreur Interne", message: "Veuillez essayer ultérieurement")
            }
        }
    }
    
    @objc func upload() {
        guard let imageData = profilPicture.imageView?.image?.jpegData(compressionQuality: 0.6) else { return }
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "myImage", fileName: "myImage.jpeg", mimeType: "image/jpeg")
        },to: Urls().BASE_URL + "upload/", method: .post)
        .uploadProgress(closure: { (progress) in
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON { response in
            print(response.result)
        }
    }
}


extension Register2Controller: UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dataSelected = pickerData[row]
        print(dataSelected)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let original = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                print("OK")
                self.profilPicture.setImage(original, for: .normal)
                self.profilPicture.imageView?.contentMode = .scaleAspectFit
                print("Bloqué ici")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
