//
//  EditPetShopViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 10.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditPetShopViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var establishDateTF: UITextField!
    @IBOutlet weak var workerCountTF: UITextField!
    @IBOutlet weak var detailTF: UITextField!
    

    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/petshop/getall"
    let apiUrlSave = Configuration.apiUrl + "/api/v1/petshop/save"
       
    var selectedId:Int? = nil
    
       //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
          
        self.disableEditing()
                  
            // if selected id has a problem, it will be equal to -1
            let checkId = selectedId ?? -1
                  
            if checkId != -1 {
                self.getPetShopDetail(ids: selectedId!)
            }
            else {
                showAlert(for: "Hata Oluştu! Lütfen geri dönünüz!")
            }
       }
    
    // MARK: GET request and Prepare Selected Data
        func getPetShopDetail(ids: Int) {
                
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

                            if i == self.selectedId {
                                let name = item["name"].stringValue
                                let address = item["address"].stringValue
                                let detail = item["details"].stringValue
                                let phone = item["phone"].stringValue
                                let email = item["email"].stringValue
                                let establish = item["birthdate"].stringValue
                                let workerCount = item["workerCount"].stringValue

                                self.nameTF.text! = name
                                self.addressTF.text! = address
                                self.detailTF.text! = detail
                                self.phoneTF.text! = phone
                                self.emailTF.text! = email
                                self.establishDateTF.text! = establish
                                self.workerCountTF.text! = workerCount
                            }
                            
                            i = i + 1
                            
                        }
                        
                        break
                    case .failure:
                        self.showAlert(for: "Bir hata oluştu. Pet Shop Listesi Getiriemedi!")
                        print(myresponse.error!)
                        break
                    }
            
                }
                
                prepareTextFields()
                
            }
            
            // MARK: Fill Data to Text Fields
            func prepareTextFields() {
                
    }
    
    // MARK: Data Preparation and POST request
      func post(){

       // prepare paramaters
       let parameters = ["id": "f592580a-e3d6-4c28-a9ed-1c02e675ef3d",
       "olusmaTarihi": nil,
       "olusturanKullanici": nil,
       "sonGuncellenmeTarihi": nil,
       "name": nameTF.text!,
       "address": addressTF.text!,
       "email": emailTF.text!,
       "phone": phoneTF.text!,
       "details": detailTF.text!,
       "birthdate": 1575331200000,
       "workerCount": workerCountTF.text!] as [String : Any?]

       // POST request
       AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
           
           // debug
           debugPrint(response)
           
           // check result is success or failure
           switch response.result {
           case .success:
               
              // refresh Pet Shop List on previous screen
              Alert.showAlertThenPreviousScreen(message: "Pet Shop düzenlemesi kaydedildi.", vc: self)
               
               break
           case .failure:
               
               // show warning to user
               print(response.error!)
               Alert.showAlert(message: "Pet Shop düzeltilirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
               break
               
           }
       
        }
       
    }
    
        // prepare
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "savePetShopSegue" {
                 let detailAnimalController = segue.destination as? DetailPetShopViewController
                 if let tempController = detailAnimalController {
                     tempController.selectedId = selectedId
                 }
             }
         }
        
        //MARK: Kaydet button in EditPetShopViewController
        @IBAction func SaveBtn(_ sender: Any) {
                     validate()
                     post()
                     getPetShopDetail(ids:selectedId!)
                }
              
           // MARK: Validation
           func validate() {
               do {
                   
                   try nameTF.validatedText(validationType: ValidatorType.petShopName)
                   try addressTF.validatedText(validationType: ValidatorType.petShopAddress)
                   try detailTF.validatedText(validationType: ValidatorType.petShopDetail)
                   try phoneTF.validatedText(validationType: ValidatorType.petShopPhoneNumber)
                   try emailTF.validatedText(validationType: ValidatorType.petShopMailAddress)
                   try establishDateTF.validatedText(validationType: ValidatorType.petShopEstablishDate)
        

                   post()
                   
              } catch(let error) {
                  Alert.showAlert(message: (error as! ValidationError).message, vc: self)
              }
           }
        
              // MARK: disableEditing
              func disableEditing() {
                  nameTF.isUserInteractionEnabled = false
                  addressTF.isUserInteractionEnabled = false
                  detailTF.isUserInteractionEnabled = false
                  phoneTF.isUserInteractionEnabled = false
                  emailTF.isUserInteractionEnabled = false
                  establishDateTF.isUserInteractionEnabled = false
                  workerCountTF.isUserInteractionEnabled = false
              }
              
              // MARK: Alert
              func showAlert(for alert: String) {
                  let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
                  let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
                  alertController.addAction(alertAction)
                  present(alertController, animated: true, completion: nil)
              }
        
            // MARK: Keyboard
            override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                
                // when clicking the UIView, keyboard will be removed
                self.view.endEditing(true)
                
            }
}
