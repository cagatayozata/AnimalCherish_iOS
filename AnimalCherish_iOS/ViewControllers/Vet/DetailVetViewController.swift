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
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var educationInfoTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var clinicInfoTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var birthDateTF: UITextField!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/vet/getall"
    
    var selectedId:Int? = nil
    
    //MARK: viewDownload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.disableEditing()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: GET request and Prepare Selected Data
    func getAnimalDetail() {
        
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
                        let id = item["id"].stringValue
                        let name = item["name"].stringValue
                        let education = item["education"].stringValue
                        let city = item["city"].stringValue
                        let state = item["ilce"].stringValue
                        let clinic = item["clinic"].stringValue
                        let phone = item["phone"].stringValue
                        let email = item["email"].stringValue
                        let birthday = item["birthdate"].stringValue
                        
                        self.idTF.text! = id
                        self.nameTF.text! = name
                        self.educationInfoTF.text! = education
                        self.cityTF.text! = city
                        self.stateTF.text! = state
                        self.clinicInfoTF.text! = clinic
                        self.phoneTF.text! = phone
                        self.emailTF.text! = email
                        self.birthDateTF.text! = birthday
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
    
    // MARK: Fill Data to Text Fields
    func prepareTextFields() {
        
    }
    
    // MARK: disableEditing
    func disableEditing() {
        
        nameTF.isUserInteractionEnabled = false
        educationInfoTF.isUserInteractionEnabled = false
        cityTF.isUserInteractionEnabled = false
        stateTF.isUserInteractionEnabled = false
        clinicInfoTF.isUserInteractionEnabled = false
        phoneTF.isUserInteractionEnabled = false
        emailTF.isUserInteractionEnabled = false
        birthDateTF.isUserInteractionEnabled = false
    }
    
    // MARK: Alert
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
