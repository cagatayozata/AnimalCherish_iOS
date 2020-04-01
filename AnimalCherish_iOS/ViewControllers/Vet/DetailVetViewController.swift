//
//  DetailVetViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 10.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailVetViewController: UIViewController {

    //MARK: IBOutlet
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var birthDateTF: UITextField!
    @IBOutlet weak var educationInfoTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var diplomaNoTF: UITextField!
    @IBOutlet weak var sicilNoTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var detailTF: UITextField!
    
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/vet/getall"
    
    var selectedId:Int? = nil
    
    //MARK: viewDownload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.disableEditing()
        
        // if selected id has a problem, it will be equal to -1
        let checkId = selectedId ?? -1
        
        if checkId != -1 {
            self.getVetDetail()
        }
        else {
            showAlert(for: "Hata Oluştu! Lütfen geri dönünüz!")
        }
    }
    
    // MARK: GET request and Prepare Selected Data
    func getVetDetail() {
        
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
                        let education = item["education"].stringValue
                        let city = item["city"].stringValue
                        let state = item["ilce"].stringValue
                        let phone = item["phone"].stringValue
                        let email = item["email"].stringValue
                        let birthday = item["birthdate"].stringValue
                        let address = item["address"].stringValue
                        let diplomaNo = item["diplomaNo"].stringValue
                        let sicilNo = item["sicilNo"].stringValue
                        let detail = item["details"].stringValue
                        
                        self.nameTF.text! = name
                        self.educationInfoTF.text! = education
                        self.cityTF.text! = city
                        self.stateTF.text! = state
                        self.phoneTF.text! = phone
                        self.emailTF.text! = email
                        self.addressTF.text! = address
                        self.diplomaNoTF.text! = diplomaNo
                        self.sicilNoTF.text! = sicilNo
                        self.detailTF.text! = detail
                    }
                    
                    i = i + 1
                    
                }
                
                break
            case .failure:
                self.showAlert(for: "Bir hata oluştu. Veteriner Hekim Listesi Getiriemedi!")
                print(myresponse.error!)
                break
            }
    
        }
        
        prepareTextFields()
        
    }
    
    // MARK: prepare to send selectedId
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "goToEditVetViewController" {
             let editVetController = segue.destination as? EditVetViewController
             if let tempController = editVetController {
                 tempController.selectedId = selectedId
             }
         }
     }
    
    // MARK: Fill Data to Text Fields
    func prepareTextFields() {
        
    }
    
    // MARK: disableEditing
    func disableEditing() {
        nameTF.isUserInteractionEnabled = false
        educationInfoTF.isUserInteractionEnabled = false
        cityTF.isUserInteractionEnabled = false
        stateTF.isUserInteractionEnabled = false
        phoneTF.isUserInteractionEnabled = false
        emailTF.isUserInteractionEnabled = false
        birthDateTF.isUserInteractionEnabled = false
        addressTF.isUserInteractionEnabled = false
        diplomaNoTF.isUserInteractionEnabled = false
        sicilNoTF.isUserInteractionEnabled = false
        detailTF.isUserInteractionEnabled = false
    }
    
    // MARK: Alert
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
