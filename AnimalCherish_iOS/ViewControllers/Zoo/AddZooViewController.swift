//
//  AddZooViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 9.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddZooViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var establishDate: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var workers: UITextField!
    @IBOutlet weak var button: UIButton!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/vet/save"
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextField Style
        establishDate.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "person", systemIcon: true)
        name.setTitleAndIcon(title: "Adı", icon: "person", systemIcon: true)
        email.setTitleAndIcon(title: "Mail Adresi", icon: "person", systemIcon: true)
        phone.setTitleAndIcon(title: "Telefon Numarası", icon: "person", systemIcon: true)
        address.setTitleAndIcon(title: "Adres", icon: "person", systemIcon: true)
        desc.setTitleAndIcon(title: "Detay", icon: "person", systemIcon: true)
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
            try establishDate.validatedText(validationType: ValidatorType.zooEstablishDate)
            try name.validatedText(validationType: ValidatorType.zooName)
            try email.validatedText(validationType: ValidatorType.zooMailAddress)
            try phone.validatedText(validationType: ValidatorType.zooPhoneNumber)
            try address.validatedText(validationType: ValidatorType.zooAddress)
            try desc.validatedText(validationType: ValidatorType.zooDescription)
            
            post()
            
       } catch(let error) {
           Alert.showAlert(message: (error as! ValidationError).message, vc: self)
       }
    }
    
    // MARK: Data Preparation and POST request
    func post(){

        // prepare paramaters
        let parameters = ["id": "4e502481-b76b-4948-bfd3-dde86d3272ac",
        "olusmaTarihi": nil,
        "olusturanKullanici": nil,
        "sonGuncellenmeTarihi": nil,
        "establishDate": 1575158400000,
        "name": name.text!,
        "address": address.text!,
        "workers": "",
        "description": desc.text!,
        "phone": phone.text!,
        "email": email.text!,
        "workerCount": workers.text!] as [String : Any?]
        
        // POST request
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            // debug
            debugPrint(response)
            
            // check result is success or failure
            switch response.result {
            case .success:
                
                // refresh Vet List on previous screen
                Alert.showAlertThenPreviousScreen(message: "Hayvanat Bahçesi başarıyla eklendi!", vc: self)
                
                break
            case .failure:
                
                // show warning to user
                print(response.error!)
                Alert.showAlert(message: "Hayvanat Bahçesi eklenirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
                break
                
            }
        
        }
    }

  
}
