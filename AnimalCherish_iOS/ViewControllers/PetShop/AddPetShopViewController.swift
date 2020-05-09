//
//  AddPetShopViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 9.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class AddPetShopViewController: UIViewController {
    // MARK: IBOutlet

    @IBOutlet var name: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var detail: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var mail: UITextField!
    @IBOutlet var establishDate: UITextField!
    @IBOutlet var workers: UITextField!
    @IBOutlet var button: UIButton!

    // MARK: Variables

    let apiUrl = Configuration.apiUrl + "/api/v1/petshop/save"

    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: TextField Style

        name.setTitleAndIcon(title: "İsim", icon: "person", systemIcon: true)
        address.setTitleAndIcon(title: "Adres", icon: "location", systemIcon: true)
        detail.setTitleAndIcon(title: "Detay", icon: "doc.text", systemIcon: true)
        phone.setTitleAndIcon(title: "Telefon Numarası", icon: "phone", systemIcon: true)
        mail.setTitleAndIcon(title: "Mail Adresi", icon: "envelope", systemIcon: true)
        establishDate.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "calendar", systemIcon: true)
        workers.setTitleAndIcon(title: "Çalışan Sayısı", icon: "person.2", systemIcon: true)

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
            try name.validatedText(validationType: ValidatorType.petShopName)
            try address.validatedText(validationType: ValidatorType.petShopAddress)
            try detail.validatedText(validationType: ValidatorType.petShopDetail)
            try phone.validatedText(validationType: ValidatorType.petShopPhoneNumber)
            try mail.validatedText(validationType: ValidatorType.petShopMailAddress)
            try establishDate.validatedText(validationType: ValidatorType.petShopEstablishDate)

            post()

        } catch {
            Alert.showAlert(message: (error as! ValidationError).message, vc: self)
        }
    }

    // MARK: Data Preparation and POST request

    func post() {
        // prepare paramaters
        let parameters = ["id": UUID().uuidString,
                          "olusmaTarihi": nil,
                          "olusturanKullanici": nil,
                          "sonGuncellenmeTarihi": nil,
                          "name": name.text!,
                          "address": address.text!,
                          "email": mail.text!,
                          "phone": phone.text!,
                          "details": detail.text!,
                          "birthdate": 1_575_331_200_000,
                          "workerCount": workers.text!] as [String: Any?]

        // POST request
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in

            // debug
            debugPrint(response)

            // check result is success or failure
            switch response.result {
            case .success:

                // refresh Pet Shop List on previous screen
                Alert.showAlertThenPreviousScreen(message: "Pet Shop başarıyla eklendi!", vc: self)

            case .failure:

                // show warning to user
                print(response.error!)
                Alert.showAlert(message: "Pet Shop eklenirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
            }
        }
    }

    // MARK: Keyboard

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        // when clicking the UIView, keyboard will be removed
        view.endEditing(true)
    }
}
