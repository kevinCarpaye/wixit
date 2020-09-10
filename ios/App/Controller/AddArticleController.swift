//
//  AddArticleController.swift
//  App
//
//  Created by Kévin CARPAYE on 16/09/2019.
//  Copyright © 2019 Konex. All rights reserved.
//

import UIKit
import Alamofire

class AddArticleController: UITableViewController {
    
    let PictureTVC: UITableViewCell = {
        let tvc = UITableViewCell()
        tvc.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tvc.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
        tvc.selectionStyle = .none
        return tvc
    }()
    
    var picture: UIButton = {
        let picture = UIButton()
        let image = UIImage(named: "image")?.withRenderingMode(.alwaysOriginal)
        picture.setImage(image, for: .normal)
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.contentMode = .scaleAspectFit
        picture.addTarget(self, action: #selector(SetArticlePicture), for: .touchUpInside)
        return picture
    }()
    
    let articleNameTVC: UITableViewCell = {
        let tvc = UITableViewCell()
        tvc.heightAnchor.constraint(equalToConstant: 80).isActive = true
        tvc.selectionStyle = .none
        tvc.backgroundColor = .white

        return tvc
    }()
    
    let articleNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NOM OU TITRE"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let articleNameTextfiel: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
        label.textColor = .black
        return label
    }()
    
    let articleBarcodeTVC: UITableViewCell = {
        let tvc = UITableViewCell()
        tvc.heightAnchor.constraint(equalToConstant: 80).isActive = true
        tvc.selectionStyle = .none
        tvc.backgroundColor = .white
        return tvc
    }()
    
    let articleBarcodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CODE BARRE"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let articleBarcodeTextfiel: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.isEnabled = false
        textfield.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
        textfield.textColor = .black
        return textfield
    }()
    
    let articleTypeTVC: UITableViewCell = {
        let tvc = UITableViewCell()
        tvc.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tvc.selectionStyle = .none
        tvc.backgroundColor = .white
        return tvc
    }()
    
    let articleTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TYPE"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    var articleTypePicker: UIPickerView = {
        let city = UIPickerView()
        city.translatesAutoresizingMaskIntoConstraints = false
        city.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
        city.setValue(UIColor.black, forKey: "textColor")
        return city
    }()
    
    var pickerData: Array = [""]
    
    var dataSelected: String = ""
    
    let picker = UIImagePickerController()
    
    var barcode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Nouvel Article"
        picker.delegate = self
        picker.allowsEditing = false
        fetchType()
        SetupViews()
        self.tabBarController?.tabBar.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(HideKeyboard))
        view.addGestureRecognizer(tap)
        tableView.separatorStyle = .none
    }
    
    func SetupViews() {
        SetupPicture()
        SetupArticleName()
        SetupArticleBarcode()
        SetupArticleType()
        SetupRightNavButton()
    }
    
    func SetupPicture() {
        
        PictureTVC.addSubview(picture)
        picture.centerXAnchor.constraint(equalTo: PictureTVC.centerXAnchor).isActive = true
        picture.centerYAnchor.constraint(equalTo: PictureTVC.centerYAnchor).isActive = true
        picture.widthAnchor.constraint(equalToConstant: PictureTVC.frame.width).isActive = true
        picture.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func SetupArticleName() {
        articleNameTVC.addSubview(articleNameLabel)
        articleNameLabel.topAnchor.constraint(equalTo: articleNameTVC.topAnchor, constant: 10).isActive = true
        articleNameLabel.leftAnchor.constraint(equalTo: articleNameTVC.leftAnchor, constant: 20).isActive = true
        articleNameLabel.rightAnchor.constraint(equalTo: articleNameTVC.rightAnchor, constant: -20).isActive = true
        articleNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        articleNameTVC.addSubview(articleNameTextfiel)
        articleNameTextfiel.topAnchor.constraint(equalTo: articleNameLabel.bottomAnchor).isActive = true
        articleNameTextfiel.leftAnchor.constraint(equalTo: articleNameTVC.leftAnchor, constant: 20).isActive = true
        articleNameTextfiel.rightAnchor.constraint(equalTo: articleNameTVC.rightAnchor, constant: -20).isActive = true
        articleNameTextfiel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        articleNameTextfiel.delegate = self
    }
    
    func SetupArticleBarcode() {
        articleBarcodeTVC.addSubview(articleBarcodeLabel)
        articleBarcodeLabel.topAnchor.constraint(equalTo: articleBarcodeTVC.topAnchor, constant: 10).isActive = true
        articleBarcodeLabel.leftAnchor.constraint(equalTo: articleBarcodeTVC.leftAnchor, constant: 20).isActive = true
        articleBarcodeLabel.rightAnchor.constraint(equalTo: articleBarcodeTVC.rightAnchor, constant: -20).isActive = true
        articleBarcodeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        articleBarcodeTVC.addSubview(articleBarcodeTextfiel)
        articleBarcodeTextfiel.topAnchor.constraint(equalTo: articleBarcodeLabel.bottomAnchor).isActive = true
        articleBarcodeTextfiel.leftAnchor.constraint(equalTo: articleBarcodeTVC.leftAnchor, constant: 20).isActive = true
        articleBarcodeTextfiel.rightAnchor.constraint(equalTo: articleBarcodeTVC.rightAnchor, constant: -20).isActive = true
        articleBarcodeTextfiel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        if self.barcode != nil && self.barcode.count == 13 {
            articleBarcodeTextfiel.text = barcode
        }
        else {
            articleBarcodeTextfiel.text = "Pas de code barre"
            articleBarcodeTextfiel.layer.borderWidth = 2
            articleBarcodeTextfiel.layer.borderColor = UIColor.red.cgColor
        }
        articleBarcodeTextfiel.delegate = self
    }
    
    func SetupArticleType() {
        articleTypeTVC.addSubview(articleTypeLabel)
        articleTypeLabel.topAnchor.constraint(equalTo: articleTypeTVC.topAnchor, constant: 10).isActive = true
        articleTypeLabel.leftAnchor.constraint(equalTo: articleTypeTVC.leftAnchor, constant: 20).isActive = true
        articleTypeLabel.rightAnchor.constraint(equalTo: articleTypeTVC.rightAnchor, constant: -20).isActive = true
        articleTypeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        articleTypeTVC.addSubview(articleTypePicker)
        articleTypePicker.topAnchor.constraint(equalTo: articleTypeLabel.bottomAnchor).isActive = true
        articleTypePicker.leftAnchor.constraint(equalTo: articleTypeTVC.leftAnchor, constant: 20).isActive = true
        articleTypePicker.rightAnchor.constraint(equalTo: articleTypeTVC.rightAnchor, constant: -20).isActive = true
        articleTypePicker.bottomAnchor.constraint(equalTo: articleTypeTVC.bottomAnchor).isActive = true
        articleTypePicker.delegate = self
    }
    
    func SetupRightNavButton() {
    //        let rightNavBut = UIBarButtonItem(customView: rightNavButton)
    //        rightNavBut.style = .plain
    //        self.nuiavigationItem.setRightBarButton(rightNavBut, animated: true)
        let image = UIImage(named: "add")?.withRenderingMode(.alwaysOriginal)
        let add = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(Check))
            navigationItem.rightBarButtonItem = add
        }
    
    @objc func HideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func Check() {
        
        let image2 = UIImage(named: "image")?.withRenderingMode(.alwaysOriginal)
        if (self.picture.imageView?.image!.isEqual(image2))! {
            print("identique")
            let alert = UIAlertController(title: "Erreur", message: "L'image est obligatoire", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            guard self.articleNameTextfiel.text!.count >= 3  else {
                articleNameTextfiel.layer.borderWidth = 2
                articleNameTextfiel.layer.borderColor = UIColor.red.cgColor
                return
            }
//            guard self.articleBarcodeTextfiel.text!.count == 13 else {
//                articleBarcodeTextfiel.layer.borderWidth = 2
//                articleBarcodeTextfiel.layer.borderColor = UIColor.red.cgColor
//                return
//            }
            
            guard self.dataSelected.count > 0 else {
                articleTypePicker.layer.borderWidth = 2
                articleTypePicker.layer.borderColor = UIColor.red.cgColor
                return
            }
            
            Request()
        }
    }
    
    func fetchType() {
        
        let url = Urls().BASE_URL + "/fetchType"
        
        AF.request(url).response { (response) in
            switch response.result {
            case .success(_):
                if let data = response.data {
                    do {
                    let responseDecoded = try JSONDecoder().decode(GetType.self, from: data)
                        if responseDecoded.request == 0 {
                            Alert().displayAlert(controller: self, title: "Erreur", message: responseDecoded.result)
                        }
                        
                        if responseDecoded.request == 1 {
                            for t in responseDecoded.response {
                                self.pickerData.append("\(t.type)")
                                print(t.type)
                                self.articleTypePicker.reloadAllComponents()
                            }
                        }
                    }
                    catch let error as NSError {
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func Request() {

        let url = Urls().BASE_URL + "/addArticle"
        let parameters : [String : String] = ["name" : articleNameTextfiel.text!, "barcode" : self.barcode, "type" : dataSelected]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let responseDecoded = try JSONDecoder().decode(AddArticleStruct.self, from: data)
                        if responseDecoded.request == 0 {
                            Alert().displayAlert(controller: self, title: "Erreur", message: responseDecoded.result)
                        }
                        
                        if responseDecoded.request == 1 {
                            self.Upload()
//                            Alert().displayAlert(controller: self, title: "Ajouté", message: responseDecoded.result)
                            //self.navigationController?.popViewController(animated: true)
                        }
                        
                        print(responseDecoded.result)
                    }
                    catch let error as NSError {
                        print(error)
                    }
                }
                break
            case .failure (let error):
                print(error)
                Alert().displayAlert(controller: self, title: "Erreur interne", message: "Veuillez réessayer ultérieurement")
            }
        }
    }
    
    func Upload() {
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        guard let imageData = picture.imageView?.image?.jpegData(compressionQuality: 0.6) else { return }
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "articleAddedPicture", fileName: "articleAddedPicture.jpeg", mimeType: "image/jpeg")
        },to: Urls().BASE_URL + "/uploadArticleImage", method: .post, headers: headers)
        .uploadProgress(closure: { (progress) in
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON { response in
            print(response.result)
            switch response.result {
                
            case .success(_):
                let alert = UIAlertController(title: "Super 💪🏾", message: "L'ajout de l'article à été éffctué avec succes et sera disponible après vérification. Nous vous remercions de votre contribution.", preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.navigationController?.popViewController(animated: true)
                }
                
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            case .failure(_):
                let alert = UIAlertController(title: "Problème d'image ❗️", message: "L'image n'a pas été envoyé, nous vous invitons à refaire l'ajout de l'article.", preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.navigationController?.popViewController(animated: true)
                }
                
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func SetArticlePicture() {
        AlertPicker().Choice(controller: self, picker: picker, forUser: false, imageButton: picture)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section)
        {
        case 0:  return 1;  // section 0 has 2 rows
        case 1:  return 1;  // section 1 has 1 row
        case 2:  return 1;
        case 3:  return 1;
        default: return 0;
        };
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.PictureTVC  // section 0, row 0 is the first name
            //case 1: return self.lastNameCell    // section 0, row 1 is the last name
            default: fatalError("Unknown row in section 0")
            }
        case 1:
            switch(indexPath.row) {
            case 0: return self.articleNameTVC       // section 1, row 0 is the share option
            default: fatalError("Unknown row in section 1")
            }
        case 2:
            switch(indexPath.row) {
            case 0: return self.articleBarcodeTVC
            default: fatalError("Unknown row in section 1")
            }
        case 3:
            switch indexPath.row {
            case 0: return self.articleTypeTVC
            default: fatalError("Unknown row in section 1")
            }
        default: fatalError("Unknown section")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow?.section
//        let indexPath = tableView.indexPathForSelectedRow!
//        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
//        let currentItem = currentCell.textLabel!.text
//        print(currentCell)
        if indexPath == 0 {
            print("case photo cliqué")
        }
    }
}


extension AddArticleController: UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if articleNameTextfiel.text!.count <= 3 {
            articleNameTextfiel.layer.borderWidth = 2
            articleBarcodeTextfiel.layer.borderColor = UIColor.red.cgColor
        }
        else {
            articleNameTextfiel.layer.borderWidth = 2
            articleBarcodeTextfiel.layer.borderColor = UIColor.green.cgColor
        }
    }
    
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
        if dataSelected.count > 0 {
            articleTypePicker.layer.borderWidth = 2
            articleTypePicker.layer.borderColor = UIColor.green.cgColor
        }
        else {
            articleTypePicker.layer.borderWidth = 2
            articleTypePicker.layer.borderColor = UIColor.red.cgColor
        }
        print(dataSelected)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if articleNameTextfiel.text!.count > 3 {
            articleNameTextfiel.layer.borderWidth = 2
            articleNameTextfiel.layer.borderColor = UIColor.green.cgColor
        }
        else {
            articleNameTextfiel.layer.borderWidth = 2
            articleNameTextfiel.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let original = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.picture.setImage(original, for: .normal)
                self.picture.imageView?.contentMode = .scaleAspectFit
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .darkContent
//    }
}




    

    
    

