//
//  AddPetShopViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 9.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class AddPetShopViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var detail: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var establishDate: UITextField!
    
    // MARK: Variables

        
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
        // MARK: TODO POST request
        
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
  
}
