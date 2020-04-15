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
    
    var selectedId:String? = nil
    
    //MARK: viewDownload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextField Style
        nameTF.setTitleAndIcon(title: "İsim Soyad", icon: "person", systemIcon: true)
        educationInfoTF.setTitleAndIcon(title: "Eğitim Bilgisi", icon: "info", systemIcon: true)
        cityTF.setTitleAndIcon(title: "Şehir", icon: "location", systemIcon: true)
        stateTF.setTitleAndIcon(title: "İlçe", icon: "location", systemIcon: true)
        addressTF.setTitleAndIcon(title: "Klinik Bilgisi", icon: "location", systemIcon: true)
        phoneTF.setTitleAndIcon(title: "Telefon Numarası", icon: "phone", systemIcon: true)
        emailTF.setTitleAndIcon(title: "Mail Adresi", icon: "envelope", systemIcon: true)
        birthDateTF.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "calendar", systemIcon: true)
        detailTF.setTitleAndIcon(title: "Detay", icon: "doc.text", systemIcon: true)
        diplomaNoTF.setTitleAndIcon(title: "Diploma No", icon: "number.circle", systemIcon: true)
        sicilNoTF.setTitleAndIcon(title: "Sicil No", icon: "number.circle", systemIcon: true)
        
        self.disableEditing()
        
        // check nil
        if selectedId != nil {
            self.getVetDetail()
        }
        else {
            Alert.showAlert(message: "Hata Oluştu! Lütfen geri dönünüz!", vc: self)
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
                    
                    if item["id"].stringValue == self.selectedId {
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
                Alert.showAlert(message: "Bir hata oluştu. Veteriner Hekim Listesi Getiriemedi!", vc: self)
                break
            }
            
        }
        
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
    
}
