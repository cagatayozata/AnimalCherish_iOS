//
//  AddAnimalViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 7.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class AddAnimalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: IBOutlet
    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var genusTextField: UITextField!
    
    // MARK: Variables
    let types = ["Köpek", "Kuş", "Yılan", "Böcek", "Balık"]
    let genus = ["Tür 1", "Tür 2", "Tür 3"]
    
    var typePickerView = UIPickerView()
    var genusPickerView = UIPickerView()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        typePickerView.delegate = self
        typePickerView.dataSource = self
        
        genusPickerView.delegate = self
        genusPickerView.dataSource = self
        
        typeTextField.inputView = typePickerView
        genusTextField.inputView = genusPickerView
        
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
            
            try IdTextField.validatedText(validationType: ValidatorType.animalId)
            try nameTextField.validatedText(validationType: ValidatorType.animalName)
            try locationTextField.validatedText(validationType: ValidatorType.location)
            try typeTextField.validatedText(validationType: ValidatorType.animalType)
            try genusTextField.validatedText(validationType: ValidatorType.animalGenus)
            
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
    
    // MARK: UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if self.typeTextField.isEditing {
            return types.count
        } else {
            return genus.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if self.typeTextField.isEditing {
            return types[row]
        } else {
            return genus[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if self.typeTextField.isEditing {
            typeTextField.text = types[row]
            typeTextField.resignFirstResponder()
        } else {
            genusTextField.text = genus[row]
            genusTextField.resignFirstResponder()
        }
        
    }

}
