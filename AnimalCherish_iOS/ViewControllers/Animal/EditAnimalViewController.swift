//
//  EditAnimalViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 10.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditAnimalViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var genusTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    // MARK: Variables
       let apiUrl = Configuration.apiUrl + "/api/v1/animal/getall"
       let apiUrlSave = Configuration.apiUrl + "/api/v1/animal/save"
       
       var selectedId:Int? = nil
       
       // MARK: viewDidLoad
       override func viewDidLoad() {
           super.viewDidLoad()
                
           self.disableEditing()
           
           // if selected id has a problem, it will be equal to -1
           let checkId = selectedId ?? -1
           
           if checkId != -1 {
            self.getAnimalDetail(ids: selectedId!)
           }
           else {
               showAlert(for: "Hata Oluştu! Lütfen geri dönünüz!")
           }
           
       }
       
       // MARK: GET request and Prepare Selected Data
    func getAnimalDetail(ids:Int) {
           
       AF.request(apiUrl, method: .get).responseJSON { (myresponse) in
  
            // check result is success or failure
            switch myresponse.result {
            case .success:
                   
            // GET data
            let myresult = try? JSON(data: myresponse.data!)
            let resultArray = myresult!
                   
            //
            var i = 0
            for item in resultArray.arrayValue {

            if i == self.selectedId  {
                let id = item["id"].stringValue
                let name = item["name"].stringValue
                let location = item["address"].stringValue
                let type = item["turAd"].stringValue
                let genus = item["cinsAd"].stringValue
                let gender = item["cinsiyet"].stringValue
                        
                self.IdTextField.text! = id
                self.nameTextField.text! = name
                self.locationTextField.text! = location
                self.typeTextField.text! = type
                self.genusTextField.text! = genus
                self.genderTextField.text! = genus
                }
                       
            i = i + 1
                       
        }
                   
        break
        case .failure:
            self.showAlert(for: "Bir hata oluştu. Hayvan Listesi Getiriemedi!")
            print(myresponse.error!)
            break
        }
       
    }
           
    prepareTextFields()
           
}
    
    // MARK: Data Preparation and POST request
    func post(){
        
        // prepare paramaters
        let parameters = ["id": IdTextField.text!,"olusmaTarihi":nil,"olusturanKullanici":"d19238c6-3578-466e-a293-3ba6f7ef1784","sonGuncellenmeTarihi":nil,"name":nameTextField.text!,"address": locationTextField.text!,"birthdate":nil,"turId":"5529ad2a-ab07-4fad-9a94-355fa7da4ca1","cinsId":"d09a1d83-5151-416a-834f-db95f510e341","cinsiyet":genderTextField.text,"sahipId":nil,"turAd":typeTextField.text!,"cinsAd": genusTextField.text!] as [String : Any?]
        
        // POST request
        AF.request(apiUrlSave, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            // debug
            debugPrint(response)
            
            // check result is success or failure
            switch response.result {
            case .success:
                // refresh Animal List on previous screen
                self.showAlert(for: ("Hayvan düzenlemesi kaydedildi."))
                break
                
            case .failure:
                // show warning to user
                print(response.error!)
                self.showWarning(for: "Hayven bilgileri düzeltilirken hata oluştu. Lütfen tekrar deneyiniz!")
                break
            }

        }
    }
    
    // prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveAnimalSegue" {
            let detailAnimalController = segue.destination as? DeatilAnimalViewController
            if let tempController = detailAnimalController {
                tempController.selectedId = selectedId
            }
        }
    }
    
    @IBAction func SaveBtn(_ sender: Any) {
        validate()
        post()
        getAnimalDetail(ids:selectedId!)
       
    }
    
    // MARK: Fill Data to Text Fiels
       func prepareTextFields() {

    }
    
     // MARK: Validation
       func validate() {
              do {
                  
                  // try IdTextField.validatedText(validationType: ValidatorType.animalId)
                  try nameTextField.validatedText(validationType: ValidatorType.animalName)
                  try locationTextField.validatedText(validationType: ValidatorType.location)
                  // try typeTextField.validatedText(validationType: ValidatorType.animalType)
                  // try genusTextField.validatedText(validationType: ValidatorType.animalGenus)
                  // try genderTextField.validatedText(validationType: ValidatorType.location)
     
             } catch(let error) {
                 showAlert(for: (error as! ValidationError).message)
             }
          }
    
       // MARK: disableEditing
       func disableEditing() {
           
           IdTextField.isUserInteractionEnabled = false
           typeTextField.isUserInteractionEnabled = false
           genusTextField.isUserInteractionEnabled = false
           genderTextField.isUserInteractionEnabled = false
           
       }
       
       // MARK: Alert
       func showAlert(for alert: String) {
           let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
           let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
           alertController.addAction(alertAction)
           present(alertController, animated: true, completion: nil)
       }
    
        // MARK: Warning
        func showWarning(for alert: String) {
            
            let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
        }
}
