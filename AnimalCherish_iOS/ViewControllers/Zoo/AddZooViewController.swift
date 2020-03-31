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
        "workerCount": 1] as [String : Any?]
        
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
            try establishDate.validatedText(validationType: ValidatorType.zooEstablishDate)
            try name.validatedText(validationType: ValidatorType.zooName)
            try email.validatedText(validationType: ValidatorType.zooMailAddress)
            try phone.validatedText(validationType: ValidatorType.zooPhoneNumber)
            try address.validatedText(validationType: ValidatorType.zooAddress)
            try desc.validatedText(validationType: ValidatorType.zooDescription)
            
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
