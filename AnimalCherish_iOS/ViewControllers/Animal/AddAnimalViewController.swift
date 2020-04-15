//
//  AddAnimalViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 7.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddAnimalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: IBOutlet
    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var genusTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/animal/save"
    let types = ["Köpek", "Kuş", "Yılan", "Böcek", "Balık"]
    let genus = ["Tür 1", "Tür 2", "Tür 3"]
    let gender = ["Dişi", "Erkek"]
    
    var typePickerView = UIPickerView()
    var genusPickerView = UIPickerView()
    var genderPickerView = UIPickerView()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // style textfields and buttons
        style()
        
        // delegate
        typePickerView.delegate = self
        typePickerView.dataSource = self
        
        genusPickerView.delegate = self
        genusPickerView.dataSource = self
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        
        // inputView
        typeTextField.inputView = typePickerView
        genusTextField.inputView = genusPickerView
        genderTextField.inputView = genderPickerView
        
    }
    
    // MARK: Pressed Functions
    @IBAction func saveButtonPressed(_ sender: Any) {
        validate()
    }
    
    // MARK: Validation
    func validate() {
        do {
            
            try IdTextField.validatedText(validationType: ValidatorType.animalId)
            try nameTextField.validatedText(validationType: ValidatorType.animalName)
            try locationTextField.validatedText(validationType: ValidatorType.location)
            try typeTextField.validatedText(validationType: ValidatorType.animalType)
            try genusTextField.validatedText(validationType: ValidatorType.animalGenus)
            
            post()
            
        } catch(let error) {
            Alert.showAlert(message: (error as! ValidationError).message, vc: self)
        }
    }
    
    // MARK: Data Preparation and POST request
    func post(){
        
        // prepare paramaters
        var tempGender:Bool
        if genderTextField.text! == "Dişi" {
            tempGender = true
        } else {
            tempGender = false
        }
        
        let parameters = ["id": IdTextField.text!,"olusmaTarihi":nil,"olusturanKullanici":"d19238c6-3578-466e-a293-3ba6f7ef1784","sonGuncellenmeTarihi":nil,"name":nameTextField.text!,"address":locationTextField.text!,"birthdate":nil,"turId":"5529ad2a-ab07-4fad-9a94-355fa7da4ca1","cinsId":"d09a1d83-5151-416a-834f-db95f510e341","cinsiyet":tempGender,"sahipId":nil,"turAd":typeTextField.text!,"cinsAd": genusTextField.text!] as [String : Any?]
        
        // POST request
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            // debug
            debugPrint(response)
            
            // check result is success or failure
            switch response.result {
            case .success:
                
                // refresh Animal List on previous screen
                Alert.showAlertThenPreviousScreen(message: "Hayvan başarıyla eklendi!", vc: self)
                
                break
            case .failure:
                
                // show warning to user
                print(response.error!)
                Alert.showAlert(message: "Hayven eklenirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
                break
                
            }
            
        }
        
    }
    
    // MARK: UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if self.typeTextField.isEditing {
            return types.count
        } else if self.genusTextField.isEditing {
            return genus.count
        } else {
            return gender.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if self.typeTextField.isEditing {
            return types[row]
        } else if self.genusTextField.isEditing {
            return genus[row]
        } else {
            return gender[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if self.typeTextField.isEditing {
            typeTextField.text = types[row]
            typeTextField.resignFirstResponder()
        } else if self.genusTextField.isEditing {
            genusTextField.text = genus[row]
            genusTextField.resignFirstResponder()
        } else {
            genderTextField.text = gender[row]
            genderTextField.resignFirstResponder()
        }
        
    }
    
    // MARK: Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // when clicking the UIView, keyboard will be removed
        self.view.endEditing(true)
        
    }
    
    // MARK: style
    func style() {
        
        // TextField Style
        IdTextField.setTitleAndIcon(title: "Küpe Numarası", icon: "star", systemIcon: true)
        nameTextField.setTitleAndIcon(title: "Hayvan Adı", icon: "person", systemIcon: true)
        locationTextField.setTitleAndIcon(title: "Konum", icon: "location", systemIcon: true)
        typeTextField.setTitleAndIcon(title: "Tür", icon: "tortoise", systemIcon: true)
        genusTextField.setTitleAndIcon(title: "Cins", icon: "tortoise", systemIcon: true)
        genderTextField.setTitleAndIcon(title: "Cinsiyet", icon: "info", systemIcon: true)
        
        // Button Button
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        
    }
    
}
