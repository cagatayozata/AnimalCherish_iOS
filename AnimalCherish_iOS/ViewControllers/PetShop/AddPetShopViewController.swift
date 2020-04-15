//
//  AddPetShopViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 9.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class AddPetShopViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var detail: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var establishDate: UITextField!
    @IBOutlet weak var workers: UITextField!
    @IBOutlet weak var button: UIButton!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/petshop/save"
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: TextField Style
        name.setTitleAndIcon(title: "İsim", icon: "person", systemIcon: true)
        address.setTitleAndIcon(title: "Adres", icon: "location", systemIcon: true)
        detail.setTitleAndIcon(title: "Detay", icon: "doc.text", systemIcon: true)
        phone.setTitleAndIcon(title: "Telefon Numarası", icon: "phone", systemIcon: true)
        mail.setTitleAndIcon(title: "Mail Adresi", icon: "envelope", systemIcon: true)
        establishDate.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "calendar", systemIcon: true)
        workers.setTitleAndIcon(title: "Çalışan Sayısı", icon: "person.2", systemIcon: true)
        
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
            
            try name.validatedText(validationType: ValidatorType.petShopName)
            try address.validatedText(validationType: ValidatorType.petShopAddress)
            try detail.validatedText(validationType: ValidatorType.petShopDetail)
            try phone.validatedText(validationType: ValidatorType.petShopPhoneNumber)
            try mail.validatedText(validationType: ValidatorType.petShopMailAddress)
            try establishDate.validatedText(validationType: ValidatorType.petShopEstablishDate)
            
            post()
            
        } catch(let error) {
            Alert.showAlert(message: (error as! ValidationError).message, vc: self)
        }
    }
    
    // MARK: Data Preparation and POST request
    func post(){
        
        // prepare paramaters
        let parameters = ["id": "f592580a-e3d6-4c28-a9ed-1c02e675ef3d",
                          "olusmaTarihi": nil,
                          "olusturanKullanici": nil,
                          "sonGuncellenmeTarihi": nil,
                          "name": name.text!,
                          "address": address.text!,
                          "email": mail.text!,
                          "phone": phone.text!,
                          "details": detail.text!,
                          "birthdate": 1575331200000,
                          "workerCount": workers.text!] as [String : Any?]
        
        // POST request
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            // debug
            debugPrint(response)
            
            // check result is success or failure
            switch response.result {
            case .success:
                
                // refresh Pet Shop List on previous screen
                Alert.showAlertThenPreviousScreen(message: "Pet Shop başarıyla eklendi!", vc: self)
                
                break
            case .failure:
                
                // show warning to user
                print(response.error!)
                Alert.showAlert(message: "Pet Shop eklenirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
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
