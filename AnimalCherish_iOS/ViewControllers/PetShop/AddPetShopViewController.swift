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
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/petshop/save"
        
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
         "workerCount": 2] as [String : Any?]
        
         // POST request
         AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
             
             // debug
             debugPrint(response)
             
             // check result is success or failure
             switch response.result {
             case .success:
                 
                 // refresh Pet Shop List on previous screen
                 self.showWarning(for: "Pet Shop başarıyla eklendi!")
                 
                 break
             case .failure:
                 
                 // show warning to user
                 print(response.error!)
                 self.showAlert(for: "Pet Shop eklenirken hata oluştu. Lütfen tekrar deneyiniz!")
                 break
                 
             }
         
         }
         
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
