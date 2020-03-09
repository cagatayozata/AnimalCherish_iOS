//
//  AddVetViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 9.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class AddVetViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var nameSurname: UITextField!
    @IBOutlet weak var educationInfo: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var workplace: UITextField!
    @IBOutlet weak var clinicInfo: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    
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
            
            try nameSurname.validatedText(validationType: ValidatorType.vetName)
            try educationInfo.validatedText(validationType: ValidatorType.vetEducationInfo)
            try city.validatedText(validationType: ValidatorType.vetCity)
            try state.validatedText(validationType: ValidatorType.vetState)
            try workplace.validatedText(validationType: ValidatorType.vetClinicInfo)
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
  
}
