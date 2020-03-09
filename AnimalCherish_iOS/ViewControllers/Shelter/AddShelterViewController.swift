//
//  AddShelterViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 9.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

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
