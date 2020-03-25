//
//  DetailZooViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 10.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailZooViewController: UIViewController {

    //MARK: IBOutlet
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var establishDateTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/zoo/getall"
    var selectedId:Int? = nil
    
    //MARK: viewDownload
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.disableEditing()
        
        // if selected id has a problem, it will be equal to -1
        let checkId = selectedId ?? -1
        
        if checkId != -1 {
            self.getZooDetail()
        }
        else {
            showAlert(for: "Hata Oluştu! Lütfen geri dönünüz!")
        }
    }
    
    // MARK: GET request and Prepare Selected Data
       func getZooDetail() {
           
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
                           let establish = item["establishDate"].stringValue
                           let address = item["address"].stringValue
                           let phone = item["phone"].stringValue
                           let email = item["email"].stringValue
                           let description = item["description"].stringValue
                        
                           self.idTF.text! = id
                           self.nameTF.text! = name
                           self.establishDateTF.text! = establish
                           self.addressTF.text! = address
                           self.descriptionTF.text! = description
                           self.phoneTF.text! = phone
                           self.emailTF.text! = email
                       }
                       
                       i = i + 1
                       
                   }
                   
                   break
               case .failure:
                   self.showAlert(for: "Bir hata oluştu. Hayvanat Bahçesi Listesi Getiriemedi!")
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
           establishDateTF.isUserInteractionEnabled = false
           addressTF.isUserInteractionEnabled = false
           descriptionTF.isUserInteractionEnabled = false
           phoneTF.isUserInteractionEnabled = false
           emailTF.isUserInteractionEnabled = false
       }
       
       // MARK: Alert
       func showAlert(for alert: String) {
           let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
           let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
           alertController.addAction(alertAction)
           present(alertController, animated: true, completion: nil)
       }

}
