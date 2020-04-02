//
//  DeatilAnimalViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 10.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DeatilAnimalViewController: UIViewController {
   
    
    // MARK: IBOutlet
    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var genusTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/animal/getall"
    
    var selectedId:Int? = nil
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.disableEditing()
        
        // if selected id has a problem, it will be equal to -1
        let checkId = selectedId ?? -1
        
        if checkId != -1 {
            self.getAnimalDetail()
        }
        else {
            showAlert(for: "Hata Oluştu! Lütfen geri dönünüz!")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          viewLoadSetup()

       }


        func viewLoadSetup(){
         // setup view did load here
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
                        let location = item["address"].stringValue
                        let type = item["turAd"].stringValue
                        let genus = item["cinsAd"].stringValue
                        let gender = item["cinsiyet"].stringValue
                        
                        self.IdTextField.text! = id
                        self.nameTextField.text! = name
                        self.locationTextField.text! = location
                        self.typeTextField.text! = type
                        self.genusTextField.text! = genus
                        self.genderTextField.text! = gender
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
    
    // MARK: Fill Data to Text Fields
    func prepareTextFields() {
        

        
    }
    
    // MARK: disableEditing
    func disableEditing() {
        
        IdTextField.isUserInteractionEnabled = false
        nameTextField.isUserInteractionEnabled = false
        locationTextField.isUserInteractionEnabled = false
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
    
    // MARK: Send selectedId to EditAnimalViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEditAnimalScreen" {
            let editAnimalController = segue.destination as? EditAnimalViewController
                if let tempController = editAnimalController {
                    tempController.selectedId = selectedId
                }
            }
        }
    }

