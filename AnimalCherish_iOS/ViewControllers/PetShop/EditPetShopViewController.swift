//
//  EditPetShopViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 10.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class EditPetShopViewController: UIViewController {
    // MARK: IBOutlet

    @IBOutlet var nameTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var establishDateTF: UITextField!
    @IBOutlet var workerCountTF: UITextField!
    @IBOutlet var detailTF: UITextField!

    // MARK: Variables

    let apiUrl = "/api/v1/petshop/getall"
    let apiUrlSave = Configuration.apiUrl + "/api/v1/petshop/save"

    var selectedId: String?

    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: TextField Style

        nameTF.setTitleAndIcon(title: "İsim", icon: "person", systemIcon: true)
        addressTF.setTitleAndIcon(title: "Adres", icon: "location", systemIcon: true)
        detailTF.setTitleAndIcon(title: "Detay", icon: "doc.text", systemIcon: true)
        phoneTF.setTitleAndIcon(title: "Telefon Numarası", icon: "phone", systemIcon: true)
        emailTF.setTitleAndIcon(title: "Mail Adresi", icon: "envelope", systemIcon: true)
        establishDateTF.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "calendar", systemIcon: true)
        workerCountTF.setTitleAndIcon(title: "Çalışan Sayısı", icon: "person.2", systemIcon: true)

        disableEditing()

        // check nil
        if selectedId != nil {
            getPetShopDetail()
        } else {
            Alert.showAlert(message: "Hata Oluştu! Lütfen geri dönünüz!", vc: self)
        }
    }

    // MARK: GET request and Prepare Selected Data

    func getPetShopDetail() {
        AF.request(apiUrl, method: .get).responseJSON { myresponse in

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

            case .failure:
                Alert.showAlert(message: "Bir hata oluştu. Pet Shop Listesi Getiriemedi!", vc: self)
            }
        }
    }

    // MARK: Data Preparation and POST request

    func post() {
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
                          "birthdate": 1_575_331_200_000,
                          "workerCount": workerCountTF.text!] as [String: Any?]

        // POST request
        AF.request(apiUrlSave, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in

            // debug
            debugPrint(response)

            // check result is success or failure
            switch response.result {
            case .success:

                // refresh Pet Shop List on previous screen
                Alert.showAlertThenPreviousScreen(message: "Pet Shop düzenlemesi kaydedildi.", vc: self)

            case .failure:

                // show warning to user
                print(response.error!)
                Alert.showAlert(message: "Pet Shop düzeltilirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
            }
        }
    }

    // MARK: Kaydet button in EditPetShopViewController

    @IBAction func SaveBtn(_: Any) {
        validate()
    }

    // MARK: Validation

    func validate() {
        do {
            try addressTF.validatedText(validationType: ValidatorType.petShopAddress)
            try detailTF.validatedText(validationType: ValidatorType.petShopDetail)
            try phoneTF.validatedText(validationType: ValidatorType.petShopPhoneNumber)
            try emailTF.validatedText(validationType: ValidatorType.petShopMailAddress)

            post()

        } catch {
            Alert.showAlert(message: (error as! ValidationError).message, vc: self)
        }
    }

    // MARK: disableEditing

    func disableEditing() {
        nameTF.isUserInteractionEnabled = false
        establishDateTF.isUserInteractionEnabled = false
    }

    // MARK: Alert

    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }

    // MARK: Keyboard

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        // when clicking the UIView, keyboard will be removed
        view.endEditing(true)
    }
}
