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
    
   // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/shelter/save"
    
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
         "workerCount": 0] as [String : Any?]
         
         // POST request
         AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
             
             // debug
             debugPrint(response)
             
             // check result is success or failure
             switch response.result {
             case .success:
                 
                 // refresh Shelter List on previous screen
                self.showAlert(for: "Barınak başarıyla eklendi!")
                 
                 break
             case .failure:
                 
                 // show warning to user
                 print(response.error!)
                 self.showAlert(for: "Barınak eklenirken hata oluştu. Lütfen tekrar deneyiniz!")
                 break
                 
             }
         
         }
         
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
  
}
