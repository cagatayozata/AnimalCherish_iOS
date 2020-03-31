//
//  AddAnimalViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 7.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol AddAnimalViewControllerDelegate {
    func animalInfo()
}

class AddAnimalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: IBOutlet
    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var genusTextField: UITextField!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/animal/save"
    let types = ["Köpek", "Kuş", "Yılan", "Böcek", "Balık"]
    let genus = ["Tür 1", "Tür 2", "Tür 3"]
    
    var typePickerView = UIPickerView()
    var genusPickerView = UIPickerView()
    var delegate: AddAnimalViewControllerDelegate?
    
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

        // prepare paramaters
        let parameters = ["id": IdTextField.text!,"olusmaTarihi":1583865345219,"olusturanKullanici":"d19238c6-3578-466e-a293-3ba6f7ef1784","sonGuncellenmeTarihi":1583865345219,"name":nameTextField.text!,"address": locationTextField.text!,"birthdate":nil,"turId":"5529ad2a-ab07-4fad-9a94-355fa7da4ca1","cinsId":"d09a1d83-5151-416a-834f-db95f510e341","cinsiyet":false,"sahipId":nil,"turAd":typeTextField.text!,"cinsAd": genusTextField.text!] as [String : Any?]
        
        // POST request
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            // debug
            debugPrint(response)
            
            // check result is success or failure
            switch response.result {
            case .success:
                
                // refresh Animal List on previous screen
                self.delegate?.animalInfo()
                self.showWarning(for: "Hayvan başarıyla eklendi!")
                
                break
            case .failure:
                
                // show warning to user
                print(response.error!)
                self.showWarning(for: "Hayven eklenirken hata oluştu. Lütfen tekrar deneyiniz!")
                break
                
            }
        
        }
        
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
    
    func showWarning(for alert: String) {
        
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        })
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
