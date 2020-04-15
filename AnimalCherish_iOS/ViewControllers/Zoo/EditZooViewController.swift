//
//  EditZooViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 10.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditZooViewController: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var establishDateTF: UITextField!
    @IBOutlet weak var workerCountTF: UITextField!
    @IBOutlet weak var detailTF: UITextField!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/zoo/getall"
    let apiUrlSave = Configuration.apiUrl + "/api/v1/zoo/save"
    var selectedId:String? = nil
    
    //MARK: viewDownload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextField Style
        establishDateTF.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "calendar", systemIcon: true)
        nameTF.setTitleAndIcon(title: "Adı", icon: "person", systemIcon: true)
        emailTF.setTitleAndIcon(title: "Mail Adresi", icon: "envelope", systemIcon: true)
        phoneTF.setTitleAndIcon(title: "Telefon Numarası", icon: "phone", systemIcon: true)
        addressTF.setTitleAndIcon(title: "Adres", icon: "location", systemIcon: true)
        detailTF.setTitleAndIcon(title: "Detay", icon: "doc.text", systemIcon: true)
        workerCountTF.setTitleAndIcon(title: "Çalışan Sayısı", icon: "person.2", systemIcon: true)
        
        self.disableEditing()
        
        // check nil
        if selectedId != nil {
            self.getZooDetail()
        }
        else {
            Alert.showAlert(message: "Hata Oluştu! Lütfen geri dönünüz!", vc: self)
        }
        
    }
    
    // MARK: GET request and Prepare Selected Data
    func getZooDetail() {
        
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
                        let establish = item["establishDate"].stringValue
                        let address = item["address"].stringValue
                        let phone = item["phone"].stringValue
                        let email = item["email"].stringValue
                        let detail = item["detail"].stringValue
                        let workerCount = item["workerCount"].stringValue
                        
                        self.nameTF.text! = name
                        self.establishDateTF.text! = establish
                        self.addressTF.text! = address
                        self.detailTF.text! = detail
                        self.phoneTF.text! = phone
                        self.emailTF.text! = email
                        self.workerCountTF.text! = workerCount
                    }
                    
                    i = i + 1
                    
                }
                
                break
            case .failure:
                Alert.showAlert(message: "Bir hata oluştu. Hayvanat Bahçesi Listesi Getiriemedi!", vc: self)
                print(myresponse.error!)
                break
            }
        }
        
    }
    
    
    @IBAction func SaveBtn(_ sender: Any) {
        validate()
    }
    
    // MARK: Validation
    func validate() {
        do {
            try establishDateTF.validatedText(validationType: ValidatorType.zooEstablishDate)
            try nameTF.validatedText(validationType: ValidatorType.zooName)
            try emailTF.validatedText(validationType: ValidatorType.zooMailAddress)
            try phoneTF.validatedText(validationType: ValidatorType.zooPhoneNumber)
            try addressTF.validatedText(validationType: ValidatorType.zooAddress)
            try detailTF.validatedText(validationType: ValidatorType.zooDescription)
            
            post()
            
        } catch(let error) {
            Alert.showAlert(message: (error as! ValidationError).message, vc: self)
        }
    }
    
    // MARK: Data Preparation and POST request
    func post(){
        
        // prepare paramaters
        let parameters = ["id": "2e502482-b75b-3448-bfd3-dde86d3272ac",
                          "olusmaTarihi": nil,
                          "olusturanKullanici": nil,
                          "sonGuncellenmeTarihi": nil,
                          "establishDate": 1575158400000,
                          "name": nameTF.text!,
                          "address": addressTF.text!,
                          "workers": "",
                          "description": detailTF.text!,
                          "phone": phoneTF.text!,
                          "email": emailTF.text!,
                          "workerCount": workerCountTF.text!] as [String : Any?]
        
        // POST request
        AF.request(apiUrlSave, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            // debug
            debugPrint(response)
            
            // check result is success or failure
            switch response.result {
            case .success:
                
                // refresh Vet List on previous screen
                Alert.showAlertThenPreviousScreen(message: "Hayvanat Bahçesi başarıyla düzenlendi.", vc: self)
                
                break
            case .failure:
                
                // show warning to user
                print(response.error!)
                Alert.showAlert(message: "Hayvanat Bahçesi düzenlenirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
                break
                
            }
            
        }
    }
    
    // MARK: disableEditing
    func disableEditing() {
        establishDateTF.isUserInteractionEnabled = false
    }
    
}
