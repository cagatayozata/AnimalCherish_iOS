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
    @IBOutlet weak var establishDateTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var detailTF: UITextField!
    @IBOutlet weak var workerCountTF: UITextField!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/zoo/getall"
    
    var selectedId:String? = nil
    
    //MARK: viewDownload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextField Style
        establishDateTF.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "calendar", systemIcon: true)
        nameTF.setTitleAndIcon(title: "Adı", icon: "person", systemIcon: true)
        emailTF.setTitleAndIcon(title: "Mail Adresi", icon: "envelope", systemIcon: true)
        phoneTF.setTitleAndIcon(title: "Telefon Numarası", icon: "phone", systemIcon: true)
        addressTF.setTitleAndIcon(title: "Adres", icon: "location", systemIcon: true)
        detailTF.setTitleAndIcon(title: "Detay", icon: "doc.text", systemIcon: true)
        workerCountTF.setTitleAndIcon(title: "Çalışan Sayısı", icon: "person.2", systemIcon: true)
        
        self.disableEditing()
        
        // check nil
        if selectedId != nil {
            self.getZooDetail()
        }
        else {
            Alert.showAlert(message: "Hata Oluştu! Lütfen geri dönünüz!", vc: self)
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
                    
                    if item["id"].stringValue == self.selectedId {
                        let name = item["name"].stringValue
                        let establish = item["establishDate"].stringValue
                        let address = item["address"].stringValue
                        let phone = item["phone"].stringValue
                        let email = item["email"].stringValue
                        let detail = item["description"].stringValue
                        let workerCount = item["workerCount"].stringValue
                        
                        self.nameTF.text! = name
                        self.establishDateTF.text! = establish
                        self.addressTF.text! = address
                        self.detailTF.text! = detail
                        self.phoneTF.text! = phone
                        self.emailTF.text! = email
                        self.workerCountTF.text! = workerCount
                    }
                    
                    i = i + 1
                    
                }
                
                break
            case .failure:
                Alert.showAlert(message: "Bir hata oluştu. Hayvanat Bahçesi Listesi Getiriemedi!", vc: self)
                break
            }
            
        }
        
    }
    
    //prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEditZooViewController" {
            let editZooController = segue.destination as? EditZooViewController
            if let tempContoller = editZooController {
                tempContoller.selectedId = selectedId
            }
        }
    }
    
    // MARK: disableEditing
    func disableEditing() {
        nameTF.isUserInteractionEnabled = false
        establishDateTF.isUserInteractionEnabled = false
        addressTF.isUserInteractionEnabled = false
        detailTF.isUserInteractionEnabled = false
        phoneTF.isUserInteractionEnabled = false
        emailTF.isUserInteractionEnabled = false
        workerCountTF.isUserInteractionEnabled = false
    }
    
}
