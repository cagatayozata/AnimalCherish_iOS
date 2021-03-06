//
//  EditVetViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 10.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class EditVetViewController: UIViewController {
    // MARK: IBOutlet

    @IBOutlet var nameTF: UITextField!
    @IBOutlet var birthdateTF: UITextField!
    @IBOutlet var educationInfoTF: UITextField!
    @IBOutlet var diplomaNoTF: UITextField!
    @IBOutlet var sicilNoTF: UITextField!
    @IBOutlet var phoneTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var stateTF: UITextField!
    @IBOutlet var cityTF: UITextField!
    @IBOutlet var detailTF: UITextField!

    // MARK: Variables

    let apiUrl = Configuration.apiUrl + "/api/v1/vet/getall"
    let apiUrlSave = Configuration.apiUrl + "/api/v1/vet/save"
    var selectedId: String?

    // MARK: viewDownload

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
        birthdateTF.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "calendar", systemIcon: true)
        detailTF.setTitleAndIcon(title: "Detay", icon: "doc.text", systemIcon: true)
        diplomaNoTF.setTitleAndIcon(title: "Diploma No", icon: "number.circle", systemIcon: true)
        sicilNoTF.setTitleAndIcon(title: "Sicil No", icon: "number.circle", systemIcon: true)

        disableEditing()

        // check nil
        if selectedId != nil {
            getVetDetail()
        } else {
            Alert.showAlert(message: "Hata Oluştu! Lütfen geri dönünüz!", vc: self)
        }
    }

    // MARK: GET request and Prepare Selected Data

    func getVetDetail() {
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
                        let education = item["education"].stringValue
                        let city = item["city"].stringValue
                        let state = item["ilce"].stringValue
                        let phone = item["phone"].stringValue
                        let email = item["email"].stringValue
                        let birthday = item["birthdate"].stringValue
                        let address = item["clinic"].stringValue
                        let diplomaNo = item["diplomaNo"].stringValue
                        let sicilNo = item["sicilNo"].stringValue
                        let detail = item["details"].stringValue

                        self.nameTF.text! = name
                        self.educationInfoTF.text! = education
                        self.cityTF.text! = city
                        self.stateTF.text! = state
                        self.phoneTF.text! = phone
                        self.emailTF.text! = email
                        self.birthdateTF.text! = birthday
                        self.addressTF.text! = address
                        self.diplomaNoTF.text! = diplomaNo
                        self.sicilNoTF.text! = sicilNo
                        self.detailTF.text! = detail
                    }

                    i = i + 1
                }

            case .failure:
                Alert.showAlert(message: "Bir hata oluştu. Veteriner Hekim Listesi Getiriemedi!", vc: self)
                print(myresponse.error!)
            }
        }
    }

    @IBAction func SaveBtn(_: Any) {
        validate()
    }

    // MARK: Validation

    func validate() {
        do {
            try nameTF.validatedText(validationType: ValidatorType.vetName)
            try educationInfoTF.validatedText(validationType: ValidatorType.vetEducationInfo)
            try cityTF.validatedText(validationType: ValidatorType.vetCity)
            try stateTF.validatedText(validationType: ValidatorType.vetState)
            try addressTF.validatedText(validationType: ValidatorType.vetClinicInfo)
            try phoneTF.validatedText(validationType: ValidatorType.vetPhoneNumber)
            try emailTF.validatedText(validationType: ValidatorType.vetMailAddress)
            try birthdateTF.validatedText(validationType: ValidatorType.vetBirthDate)

            post()

        } catch {
            Alert.showAlert(message: (error as! ValidationError).message, vc: self)
        }
    }

    // MARK: Data Preparation and POST request

    func post() {
        // prepare paramaters
        let parameters = ["id": "3c7c0a75-3d2b-428a-bf65-ed25686a5357",
                          "olusmaTarihi": nil,
                          "olusturanKullanici": nil,
                          "sonGuncellenmeTarihi": nil,
                          "name": nameTF.text!,
                          "education": educationInfoTF.text!,
                          "phone": phoneTF.text!,
                          "email": emailTF.text!,
                          "workplace": nil,
                          "clinic": addressTF.text!,
                          "details": detailTF.text!,
                          "birthdate": 831_340_800_000,
                          "city": cityTF.text!,
                          "ilce": stateTF.text!,
                          "diplomaNo": diplomaNoTF.text!,
                          "userId": nil,
                          "sicilNo": sicilNoTF.text!,
                          "kullaniciId": nil,
                          "kullaniciAdi": nil] as [String: Any?]

        // POST request
        AF.request(apiUrlSave, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in

            // debug
            debugPrint(response)

            // check result is success or failure
            switch response.result {
            case .success:

                // refresh Vet List on previous screen
                Alert.showAlertThenPreviousScreen(message: "Veteriner başarıyla eklendi!", vc: self)

            case .failure:

                // show warning to user
                print(response.error!)
                Alert.showAlert(message: "Veteriner eklenirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
            }
        }
    }

    // MARK: Keyboard

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        // when clicking the UIView, keyboard will be removed
        view.endEditing(true)
    }

    // MARK: disableEditing

    func disableEditing() {
        nameTF.isUserInteractionEnabled = false
        educationInfoTF.isUserInteractionEnabled = false
        birthdateTF.isUserInteractionEnabled = false
        diplomaNoTF.isUserInteractionEnabled = false
        sicilNoTF.isUserInteractionEnabled = false
    }
}
