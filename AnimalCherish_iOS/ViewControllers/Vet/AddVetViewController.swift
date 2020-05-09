//
//  AddVetViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 9.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class AddVetViewController: UIViewController {
    // MARK: IBOutlet

    @IBOutlet var nameSurname: UITextField!
    @IBOutlet var educationInfo: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var state: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var birthDate: UITextField!
    @IBOutlet var detail: UITextField!
    @IBOutlet var diplomaNo: UITextField!
    @IBOutlet var sicilNo: UITextField!
    @IBOutlet var button: UIButton!

    // MARK: Variables

    let apiUrl = Configuration.apiUrl + "/api/v1/vet/save"

    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        // TextField Style
        nameSurname.setTitleAndIcon(title: "İsim Soyad", icon: "person", systemIcon: true)
        educationInfo.setTitleAndIcon(title: "Eğitim Bilgisi", icon: "info", systemIcon: true)
        city.setTitleAndIcon(title: "Şehir", icon: "location", systemIcon: true)
        state.setTitleAndIcon(title: "İlçe", icon: "location", systemIcon: true)
        address.setTitleAndIcon(title: "Klinik Bilgisi", icon: "location", systemIcon: true)
        phone.setTitleAndIcon(title: "Telefon Numarası", icon: "phone", systemIcon: true)
        email.setTitleAndIcon(title: "Mail Adresi", icon: "envelope", systemIcon: true)
        birthDate.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "calendar", systemIcon: true)
        detail.setTitleAndIcon(title: "Detay", icon: "doc.text", systemIcon: true)
        diplomaNo.setTitleAndIcon(title: "Diploma No", icon: "number.circle", systemIcon: true)
        sicilNo.setTitleAndIcon(title: "Sicil No", icon: "number.circle", systemIcon: true)

        // Button Button
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
    }

    // MARK: Pressed Functions

    @IBAction func saveButtonPressed(_: Any) {
        validate()
    }

    // MARK: Validation

    func validate() {
        do {
            try nameSurname.validatedText(validationType: ValidatorType.vetName)
            try educationInfo.validatedText(validationType: ValidatorType.vetEducationInfo)
            try city.validatedText(validationType: ValidatorType.vetCity)
            try state.validatedText(validationType: ValidatorType.vetState)
            try address.validatedText(validationType: ValidatorType.vetClinicInfo)
            try phone.validatedText(validationType: ValidatorType.vetPhoneNumber)
            try email.validatedText(validationType: ValidatorType.vetMailAddress)
            try birthDate.validatedText(validationType: ValidatorType.vetBirthDate)

            post()

        } catch {
            Alert.showAlert(message: (error as! ValidationError).message, vc: self)
        }
    }

    // MARK: Data Preparation and POST request

    func post() {
        // prepare paramaters
        let parameters = ["id": "1c7c0a75-3d2b-428a-bf65-ed25686a5357",
                          "olusmaTarihi": nil,
                          "olusturanKullanici": nil,
                          "sonGuncellenmeTarihi": nil,
                          "name": nameSurname.text!,
                          "education": educationInfo.text!,
                          "phone": phone.text!,
                          "email": email.text!,
                          "workplace": nil,
                          "clinic": address.text!,
                          "details": detail.text!,
                          "birthdate": 831_340_800_000,
                          "city": city.text!,
                          "ilce": state.text!,
                          "diplomaNo": diplomaNo.text!,
                          "userId": nil,
                          "sicilNo": sicilNo.text!,
                          "kullaniciId": nil,
                          "kullaniciAdi": nil] as [String: Any?]

        // POST request
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in

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
}
