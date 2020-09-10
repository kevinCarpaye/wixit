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
    
    let registerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        let image = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
        picture.setImage(image, for: .normal)
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.contentMode = .scaleToFill
        picture.addTarget(self, action: #selector(picked), for: .touchUpInside)
        picture.clipsToBounds = true
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
        view.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        self.navigationItem.title = "Incription"
        picker.delegate = self
        picker.allowsEditing = false
        SetupViews()
    }
    
    func SetupViews() {
        
        setupRegisterView()
        setupButton()
        SetupCity()
        SetupCityLabel()
        SetupProfilPicture()
        SetupProfilLabel()
        
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupRegisterView () {
        view.addSubview(registerView)
        NSLayoutConstraint.activate([
            registerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            registerView.widthAnchor.constraint(equalToConstant: 320),
            registerView.heightAnchor.constraint(equalToConstant: 450)
        ])
        //registerView.transform = CGAffineTransform(scaleX: 0, y: 0)
        registerView.backgroundColor = .white
    }
    
    func SetupProfilLabel() {
        registerView.addSubview(profilPictureLabel)
        profilPictureLabel.bottomAnchor.constraint(equalTo: profilPicture.topAnchor, constant: -10).isActive = true
        profilPictureLabel.leftAnchor.constraint(equalTo: registerView.leftAnchor, constant: 20).isActive = true
        profilPictureLabel.rightAnchor.constraint(equalTo: registerView.rightAnchor, constant: -20).isActive = true
        profilPictureLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func SetupProfilPicture() {
        registerView.addSubview(profilPicture)
        profilPicture.bottomAnchor.constraint(equalTo: cityLabel.topAnchor, constant: -20).isActive = true
        profilPicture.centerXAnchor.constraint(equalTo: registerView.centerXAnchor).isActive = true
        //profilPicture.leftAnchor.constraint(equalTo: cityLabel.leftAnchor, constant: 20).isActive = true
        //profilPicture.rightAnchor.constraint(equalTo: cityLabel.rightAnchor, constant: -20).isActive = true
        profilPicture.widthAnchor.constraint(equalToConstant: 110).isActive = true
        profilPicture.heightAnchor.constraint(equalToConstant: 110).isActive = true
        profilPicture.layer.cornerRadius = 55
        
    }
    
    func SetupCityLabel() {
        registerView.addSubview(cityLabel)
        cityLabel.bottomAnchor.constraint(equalTo: city.topAnchor, constant: -10).isActive = true
        cityLabel.leftAnchor.constraint(equalTo: registerView.leftAnchor, constant: 20).isActive = true
        cityLabel.rightAnchor.constraint(equalTo: registerView.rightAnchor, constant: -20).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func SetupCity() {
        registerView.addSubview(city)
        city.leftAnchor.constraint(equalTo: registerView.leftAnchor, constant: 20).isActive = true
        city.rightAnchor.constraint(equalTo: registerView.rightAnchor, constant: -20).isActive = true
        city.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20).isActive = true
        city.heightAnchor.constraint(equalToConstant: 120).isActive = true
        city.delegate = self
    }
    
    func setupButton() {
        registerView.addSubview(button)
        button.bottomAnchor.constraint(equalTo: registerView.bottomAnchor, constant: -50).isActive = true
        button.leftAnchor.constraint(equalTo: registerView.leftAnchor, constant: 20).isActive = true
        button.rightAnchor.constraint(equalTo: registerView.rightAnchor, constant: -20).isActive = true
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
                
                            let alert = UIAlertController(title: "Compte crée", message: "Vous êtes dirigés vers la page de connxion", preferredStyle: .alert)
                            
                            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                                self.navigationController?.pushViewController(LoginController(), animated: true)
                            }
                            
                            alert.addAction(ok)
                            
                            self.present(alert, animated: true, completion: nil)
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
