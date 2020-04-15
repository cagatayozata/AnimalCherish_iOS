//
//  EditVetViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 10.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditVetViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var birthdateTF: UITextField!
    @IBOutlet weak var educationInfoTF: UITextField!
    @IBOutlet weak var diplomaNoTF: UITextField!
    @IBOutlet weak var sicilNoTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var detailTF: UITextField!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/vet/getall"
    let apiUrlSave = Configuration.apiUrl + "/api/v1/vet/save"
    var selectedId:String? = nil
    
    //MARK: viewDownload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.disableEditing()
        
        // check nil
        if selectedId != nil {
            self.getVetDetail()
        }
        else {
            Alert.showAlert(message: "Hata Oluştu! Lütfen geri dönünüz!", vc: self)
        }
        
    }
    
    // MARK: GET request and Prepare Selected Data
    func getVetDetail() {
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
                        let education = item["education"].stringValue
                        let city = item["city"].stringValue
                        let state = item["ilce"].stringValue
                        let phone = item["phone"].stringValue
                        let email = item["email"].stringValue
                        let birthday = item["birthdate"].stringValue
                        let address = item["address"].stringValue
                        let diplomaNo = item["diplomaNo"].stringValue
                        let sicilNo = item["sicilNo"].stringValue
                        let detail = item["details"].stringValue
                        
                        self.nameTF.text! = name
                        self.educationInfoTF.text! = education
                        self.cityTF.text! = city
                        self.stateTF.text! = state
                        self.phoneTF.text! = phone
                        self.emailTF.text! = email
                        self.birthdateTF.text! = birthday
                        self.addressTF.text! = address
                        self.diplomaNoTF.text! = diplomaNo
                        self.sicilNoTF.text! = sicilNo
                        self.detailTF.text! = detail
                    }
                    
                    i = i + 1
                    
                }
                
                break
            case .failure:
                Alert.showAlert(message: "Bir hata oluştu. Veteriner Hekim Listesi Getiriemedi!", vc: self)
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
            
            try nameTF.validatedText(validationType: ValidatorType.vetName)
            try educationInfoTF.validatedText(validationType: ValidatorType.vetEducationInfo)
            try cityTF.validatedText(validationType: ValidatorType.vetCity)
            try stateTF.validatedText(validationType: ValidatorType.vetState)
            try addressTF.validatedText(validationType: ValidatorType.vetClinicInfo)
            try phoneTF.validatedText(validationType: ValidatorType.vetPhoneNumber)
            try emailTF.validatedText(validationType: ValidatorType.vetMailAddress)
            try birthdateTF.validatedText(validationType: ValidatorType.vetBirthDate)
            
            post()
            
        } catch(let error) {
            Alert.showAlert(message: (error as! ValidationError).message, vc: self)
        }
    }
    
    // MARK: Data Preparation and POST request
    func post(){
        
        // prepare paramaters
        let parameters = ["id": "3c7c0a75-3d2b-428a-bf65-ed25686a5357",
                          "olusmaTarihi": nil,
                          "olusturanKullanici": nil,
                          "sonGuncellenmeTarihi": nil,
                          "name": nameTF.text!,
                          "education": educationInfoTF.text!,
                          "phone": phoneTF.text!,
                          "email": emailTF.text!,
                          "workplace": nil,
                          "clinic": addressTF.text!,
                          "details": detailTF.text!,
                          "birthdate": 831340800000,
                          "city": cityTF.text!,
                          "ilce": stateTF.text!,
                          "diplomaNo": diplomaNoTF.text!,
                          "userId": nil,
                          "sicilNo": sicilNoTF.text!,
                          "kullaniciId": nil,
                          "kullaniciAdi": nil] as [String : Any?]
        
        // POST request
        AF.request(apiUrlSave, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            // debug
            debugPrint(response)
            
            // check result is success or failure
            switch response.result {
            case .success:
                
                // refresh Vet List on previous screen
                Alert.showAlertThenPreviousScreen(message: "Veteriner başarıyla eklendi!", vc: self)
                
                break
            case .failure:
                
                // show warning to user
                print(response.error!)
                Alert.showAlert(message: "Veteriner eklenirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
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
        educationInfoTF.isUserInteractionEnabled = false
        birthdateTF.isUserInteractionEnabled = false
        diplomaNoTF.isUserInteractionEnabled = false
        sicilNoTF.isUserInteractionEnabled = false
    }
    
}
