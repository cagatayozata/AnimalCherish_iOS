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
    @IBOutlet weak var clinicInfo: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    
     // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/vet/save"
        
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Pressed Functions
    @IBAction func saveButtonPressed(_ sender: Any) {
        validate()
    }
    
    // MARK: Data Preparation and POST request
    func post(){

        // prepare paramaters
        let parameters = [        "id": "3c7c0a75-3d2b-428a-bf65-ed25686a5357",
        "olusmaTarihi": nil,
        "olusturanKullanici": nil,
        "sonGuncellenmeTarihi": 1583947209624,
        "name": nameSurname.text!,
        "education": educationInfo.text!,
        "phone": phone.text!,
        "email": email.text!,
        "workplace": nil,
        "clinic": "PetClinic No 15.",
        "details": "Ankarada 1996 tarihinde kurulmuş, hafta sonu dahil 24 saat hizmet veren bir kliniktir.",
        "birthdate": 831340800000,
        "city": city.text!,
        "ilce": state.text!,
        "diplomaNo": "6456418765465",
        "userId": nil,
        "sicilNo": "87894641679",
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
                self.showWarning(for: "Veteriner başarıyla eklendi!")
                
                break
            case .failure:
                
                // show warning to user
                print(response.error!)
                self.showAlert(for: "Veteriner eklenirken hata oluştu. Lütfen tekrar deneyiniz!")
                break
                
            }
        
        }
        
    }
    
    // MARK: Validation
    func validate() {
        do {
            
            try nameSurname.validatedText(validationType: ValidatorType.vetName)
            try educationInfo.validatedText(validationType: ValidatorType.vetEducationInfo)
            try city.validatedText(validationType: ValidatorType.vetCity)
            try state.validatedText(validationType: ValidatorType.vetState)
            try clinicInfo.validatedText(validationType: ValidatorType.vetClinicInfo)
            try phone.validatedText(validationType: ValidatorType.vetPhoneNumber)
            try email.validatedText(validationType: ValidatorType.vetMailAddress)
            try birthDate.validatedText(validationType: ValidatorType.vetBirthDate)
            
            post()
            
       } catch(let error) {
           showAlert(for: (error as! ValidationError).message)
       }
    }
    
    // MARK: Alert
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showWarning(for alert: String) {
        
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }
  
}
