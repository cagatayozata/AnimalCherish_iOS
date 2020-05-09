//
//  EditShelterViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 10.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditShelterViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var establishDateTF: UITextField!
    @IBOutlet weak var workerCountTF: UITextField!
    @IBOutlet weak var capacityTF: UITextField!
    @IBOutlet weak var detailTF: UITextField!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/shelter/getall"
    let apiUrlSave = Configuration.apiUrl + "/api/v1/shelter/save"
    var selectedId:String? = nil
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextField Style
        nameTF.setTitleAndIcon(title: "İsim", icon: "person", systemIcon: true)
        addressTF.setTitleAndIcon(title: "Adres", icon: "location", systemIcon: true)
        capacityTF.setTitleAndIcon(title: "Kapsasite", icon: "number", systemIcon: true)
        detailTF.setTitleAndIcon(title: "Detay", icon: "doc.text", systemIcon: true)
        phoneTF.setTitleAndIcon(title: "Telefon Numarası", icon: "phone", systemIcon: true)
        emailTF.setTitleAndIcon(title: "Mail Adresi", icon: "envelope", systemIcon: true)
        establishDateTF.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "calendar", systemIcon: true)
        workerCountTF.setTitleAndIcon(title: "Çalışan Sayısı", icon: "person.2", systemIcon: true)
        
        self.disableEditing()
        
        // check nil
        if selectedId != nil {
            self.getShelterDetail(ids: selectedId!)
        }
        else {
            Alert.showAlert(message: "Hata Oluştu! Lütfen geri dönünüz!", vc: self)
        }
        
    }
    
    // MARK: GET request and Prepare Selected Data
    func getShelterDetail(ids: String) {
        
        AF.request(apiUrl, method: .get).responseJSON { (myresponse) in
            
            // check result is success or failure
            switch myresponse.result {
            case .success:
                
                // GET data
                let myresult = try? JSON(data: myresponse.data!)
                let resultArray = myresult!
                
                //
                var i = 0
                for item in resultArray.arrayValue {
                    
                    if item["id"].stringValue == self.selectedId {
                        let name = item["name"].stringValue
                        let establish = item["birthdate"].stringValue
                        let address = item["address"].stringValue
                        let phone = item["phone"].stringValue
                        let email = item["email"].stringValue
                        let detail = item["details"].stringValue
                        let capacity = item["capacity"].stringValue
                        let workerCount = item["workerCount"].stringValue
                        
                        self.nameTF.text! = name
                        self.establishDateTF.text! = establish
                        self.addressTF.text! = address
                        self.detailTF.text! = detail
                        self.phoneTF.text! = phone
                        self.emailTF.text! = email
                        self.capacityTF.text! = capacity
                        self.workerCountTF.text! = workerCount
                    }
                    
                    i = i + 1
                    
                }
                
                break
            case .failure:
                Alert.showAlert(message: "Bir hata oluştu. Barınak Listesi Getiriemedi!", vc: self)
                print(myresponse.error!)
                break
            }
            
        }
        
    }
    
    // MARK: Post data
    @IBAction func SaveBtn(_ sender: Any) {
        validate()
    }
    
    
    // MARK: Validation
    func validate() {
        do {
            
            try nameTF.validatedText(validationType: ValidatorType.shelterName)
            try addressTF.validatedText(validationType: ValidatorType.shelterAddress)
            try capacityTF.validatedText(validationType: ValidatorType.shelterCapacity)
            try detailTF.validatedText(validationType: ValidatorType.shelterDetail)
            try phoneTF.validatedText(validationType: ValidatorType.shelterPhoneNumber)
            try emailTF.validatedText(validationType: ValidatorType.shelterMailAddress)
            
            post()
            
        } catch(let error) {
            Alert.showAlert(message: (error as! ValidationError).message, vc: self)
        }
    }
    
    // MARK: Data Preparation and POST request
    func post(){
        
        // prepare paramaters
        let parameters = ["id": "d4bc2f9f-ebde-4e00-b91f-c3e0a970e1e5",
                          "olusmaTarihi": nil,
                          "olusturanKullanici": nil,
                          "sonGuncellenmeTarihi": nil,
                          "name": nameTF.text!,
                          "address": addressTF.text!,
                          "capacity": capacityTF.text!,
                          "email": emailTF.text!,
                          "phone": phoneTF.text!,
                          "details": detailTF.text!,
                          "birthdate": 1575158400000,
                          "workerCount": workerCountTF.text!] as [String : Any?]
        
        // POST request
        AF.request(apiUrlSave, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
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
                Alert.showAlert(message: "Barınak eklenirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
                break
                
            }
            
        }
        
    }
    
    // MARK: Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // when clicking the UIView, keyboard will be removed
        self.view.endEditing(true)
        
    }
    
    // MARK: disableEditing
    func disableEditing() {
        nameTF.isUserInteractionEnabled = false
        establishDateTF.isUserInteractionEnabled = false
    }
    
}
