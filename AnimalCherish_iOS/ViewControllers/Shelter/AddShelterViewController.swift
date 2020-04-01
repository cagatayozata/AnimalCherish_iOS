//
//  AddShelterViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 9.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddShelterViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var capacity: UITextField!
    @IBOutlet weak var detail: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var establishDate: UITextField!
    @IBOutlet weak var workers: UITextField!
    @IBOutlet weak var button: UIButton!
    
   // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/shelter/save"
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextField Style
        name.setTitleAndIcon(title: "İsim", icon: "person", systemIcon: true)
        address.setTitleAndIcon(title: "Adres", icon: "person", systemIcon: true)
        capacity.setTitleAndIcon(title: "Kapsasite", icon: "person", systemIcon: true)
        detail.setTitleAndIcon(title: "Detay", icon: "person", systemIcon: true)
        phone.setTitleAndIcon(title: "Telefon Numarası", icon: "person", systemIcon: true)
        mail.setTitleAndIcon(title: "Mail Adresi", icon: "person", systemIcon: true)
        establishDate.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "person", systemIcon: true)
        workers.setTitleAndIcon(title: "Çalışan Sayısı", icon: "person", systemIcon: true)
        
        // Button Button
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        
    }
    
    // MARK: Pressed Functions
    @IBAction func saveButtonPressed(_ sender: Any) {
        validate()
    }
    
    // MARK: Validation
    func validate() {
        do {
            
            try name.validatedText(validationType: ValidatorType.shelterName)
            try address.validatedText(validationType: ValidatorType.shelterAddress)
            try capacity.validatedText(validationType: ValidatorType.shelterCapacity)
            try detail.validatedText(validationType: ValidatorType.shelterDetail)
            try phone.validatedText(validationType: ValidatorType.shelterPhoneNumber)
            try mail.validatedText(validationType: ValidatorType.shelterMailAddress)
            try establishDate.validatedText(validationType: ValidatorType.shelterEstablishDate)
            
            post()
            
       } catch(let error) {
           Alert.showAlert(message: (error as! ValidationError).message, vc: self)
       }
    }
    
    // MARK: Data Preparation and POST request
     func post(){

         // prepare paramaters
         let parameters = ["id": "d4bc2f7f-ebde-4e00-b91f-c3e0a970e1e5",
         "olusmaTarihi": nil,
         "olusturanKullanici": nil,
         "sonGuncellenmeTarihi": nil,
         "name": name.text!,
         "address": address.text!,
         "capacity": capacity.text!,
         "email": mail.text!,
         "phone": phone.text!,
         "details": detail.text!,
         "birthdate": 1575158400000,
         "workerCount": workers.text!] as [String : Any?]
         
         // POST request
         AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
             
             // debug
             debugPrint(response)
             
             // check result is success or failure
             switch response.result {
             case .success:
                 
                 // refresh Shelter List on previous screen
                Alert.showAlertThenPreviousScreen(message: "Barınak başarıyla eklendi!", vc: self)
                 
                 break
             case .failure:
                 
                 // show warning to user
                 print(response.error!)
                 Alert.showAlert(message: "Hayven eklenirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
                 break
                 
             }
         
         }
         
     }
    
    // MARK: Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
           // when clicking the UIView, keyboard will be removed
           self.view.endEditing(true)
       
    }
  
}
