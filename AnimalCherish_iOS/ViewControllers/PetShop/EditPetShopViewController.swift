//
//  EditPetShopViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 10.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditPetShopViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var establishDateTF: UITextField!
    @IBOutlet weak var workerCountTF: UITextField!
    @IBOutlet weak var detailTF: UITextField!
    
    
    // MARK: Variables
    let apiUrl = "http://138.68.67.165/api/v1/petshop/getall"
    let apiUrlSave = Configuration.apiUrl + "/api/v1/petshop/save"
    
    var selectedId:String? = nil
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: TextField Style
        nameTF.setTitleAndIcon(title: "İsim", icon: "person", systemIcon: true)
        addressTF.setTitleAndIcon(title: "Adres", icon: "location", systemIcon: true)
        detailTF.setTitleAndIcon(title: "Detay", icon: "doc.text", systemIcon: true)
        phoneTF.setTitleAndIcon(title: "Telefon Numarası", icon: "phone", systemIcon: true)
        emailTF.setTitleAndIcon(title: "Mail Adresi", icon: "envelope", systemIcon: true)
        establishDateTF.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "calendar", systemIcon: true)
        workerCountTF.setTitleAndIcon(title: "Çalışan Sayısı", icon: "person.2", systemIcon: true)
        
        self.disableEditing()
        
        // check nil
        if selectedId != nil {
            self.getPetShopDetail()
        }
        else {
            Alert.showAlert(message: "Hata Oluştu! Lütfen geri dönünüz!", vc: self)
        }
    }
    
    // MARK: GET request and Prepare Selected Data
    func getPetShopDetail() {
        
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
                        let address = item["address"].stringValue
                        let detail = item["details"].stringValue
                        let phone = item["phone"].stringValue
                        let email = item["email"].stringValue
                        let establish = item["birthdate"].stringValue
                        let workerCount = item["workerCount"].stringValue
                        
                        self.nameTF.text! = name
                        self.addressTF.text! = address
                        self.detailTF.text! = detail
                        self.phoneTF.text! = phone
                        self.emailTF.text! = email
                        self.establishDateTF.text! = establish
                        self.workerCountTF.text! = workerCount
                    }
                    
                    i = i + 1
                    
                }
                
                break
            case .failure:
                Alert.showAlert(message: "Bir hata oluştu. Pet Shop Listesi Getiriemedi!", vc: self)
                break
            }
            
        }
        
        
    }
    
    // MARK: Data Preparation and POST request
    func post(){
        
        // prepare paramaters
        let parameters = ["id": "f592580a-e3d6-4c28-a9ed-1c02e675ef3d",
                          "olusmaTarihi": nil,
                          "olusturanKullanici": nil,
                          "sonGuncellenmeTarihi": nil,
                          "name": nameTF.text!,
                          "address": addressTF.text!,
                          "email": emailTF.text!,
                          "phone": phoneTF.text!,
                          "details": detailTF.text!,
                          "birthdate": 1575331200000,
                          "workerCount": workerCountTF.text!] as [String : Any?]
        
        // POST request
        AF.request(apiUrlSave, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            // debug
            debugPrint(response)
            
            // check result is success or failure
            switch response.result {
            case .success:
                
                // refresh Pet Shop List on previous screen
                Alert.showAlertThenPreviousScreen(message: "Pet Shop düzenlemesi kaydedildi.", vc: self)
                
                break
            case .failure:
                
                // show warning to user
                print(response.error!)
                Alert.showAlert(message: "Pet Shop düzeltilirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
                break
                
            }
            
        }
        
    }
    
    //MARK: Kaydet button in EditPetShopViewController
    @IBAction func SaveBtn(_ sender: Any) {
        validate()
    }
    
    // MARK: Validation
    func validate() {
        do {
            
            try addressTF.validatedText(validationType: ValidatorType.petShopAddress)
            try detailTF.validatedText(validationType: ValidatorType.petShopDetail)
            try phoneTF.validatedText(validationType: ValidatorType.petShopPhoneNumber)
            try emailTF.validatedText(validationType: ValidatorType.petShopMailAddress)
            
            post()
            
        } catch(let error) {
            Alert.showAlert(message: (error as! ValidationError).message, vc: self)
        }
    }
    
    // MARK: disableEditing
    func disableEditing() {
        nameTF.isUserInteractionEnabled = false
        establishDateTF.isUserInteractionEnabled = false
    }
    
    // MARK: Alert
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // when clicking the UIView, keyboard will be removed
        self.view.endEditing(true)
        
    }
}
