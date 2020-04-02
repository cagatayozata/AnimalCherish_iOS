//
//  AddVetViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 9.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddVetViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var nameSurname: UITextField!
    @IBOutlet weak var educationInfo: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var detail: UITextField!
    @IBOutlet weak var diplomaNo: UITextField!
    @IBOutlet weak var sicilNo: UITextField!
    @IBOutlet weak var button: UIButton!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/vet/save"
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextField Style
        nameSurname.setTitleAndIcon(title: "İsim Soyad", icon: "person", systemIcon: true)
        educationInfo.setTitleAndIcon(title: "Eğitim Bilgisi", icon: "person", systemIcon: true)
        city.setTitleAndIcon(title: "Şehir", icon: "person", systemIcon: true)
        state.setTitleAndIcon(title: "İlçe", icon: "person", systemIcon: true)
        address.setTitleAndIcon(title: "Klinik Bilgisi", icon: "person", systemIcon: true)
        phone.setTitleAndIcon(title: "Telefon Numarası", icon: "person", systemIcon: true)
        email.setTitleAndIcon(title: "Mail Adresi", icon: "person", systemIcon: true)
        birthDate.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "person", systemIcon: true)
        detail.setTitleAndIcon(title: "Detay", icon: "person", systemIcon: true)
        diplomaNo.setTitleAndIcon(title: "Diploma No", icon: "person", systemIcon: true)
        sicilNo.setTitleAndIcon(title: "Sicil No", icon: "person", systemIcon: true)
        
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
            
             try nameSurname.validatedText(validationType: ValidatorType.vetName)
             try educationInfo.validatedText(validationType: ValidatorType.vetEducationInfo)
             try city.validatedText(validationType: ValidatorType.vetCity)
             try state.validatedText(validationType: ValidatorType.vetState)
             try address.validatedText(validationType: ValidatorType.vetClinicInfo)
             try phone.validatedText(validationType: ValidatorType.vetPhoneNumber)
             try email.validatedText(validationType: ValidatorType.vetMailAddress)
             try birthDate.validatedText(validationType: ValidatorType.vetBirthDate)
             
            post()
            
        } catch(let error) {
            Alert.showAlert(message: (error as! ValidationError).message, vc: self)
        }
    }
    
    // MARK: Data Preparation and POST request
    func post(){
        
        // prepare paramaters
        let parameters = [        "id": "1c7c0a75-3d2b-428a-bf65-ed25686a5357",
                                  "olusmaTarihi": nil,
                                  "olusturanKullanici": nil,
                                  "sonGuncellenmeTarihi": nil,
                                  "name": nameSurname.text!,
                                  "education": educationInfo.text!,
                                  "phone": phone.text!,
                                  "email": email.text!,
                                  "workplace": nil,
                                  "clinic": address.text!,
                                  "details": detail.text!,
                                  "birthdate": 831340800000,
                                  "city": city.text!,
                                  "ilce": state.text!,
                                  "diplomaNo": diplomaNo.text!,
                                  "userId": nil,
                                  "sicilNo": sicilNo.text!,
                                  "kullaniciId": nil,
                                  "kullaniciAdi": nil] as [String : Any?]
        
        // POST request
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
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
    
}
