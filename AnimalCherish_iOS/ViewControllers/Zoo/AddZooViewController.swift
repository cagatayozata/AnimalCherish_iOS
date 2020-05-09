//
//  AddZooViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 9.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class AddZooViewController: UIViewController {
    // MARK: IBOutlet

    @IBOutlet var establishDate: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var desc: UITextField!
    @IBOutlet var workers: UITextField!
    @IBOutlet var button: UIButton!

    // MARK: Variables

    let apiUrl = Configuration.apiUrl + "/api/v1/zoo/save"

    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        // TextField Style
        establishDate.setTitleAndIcon(title: "Kuruluş Tarihi", icon: "calendar", systemIcon: true)
        name.setTitleAndIcon(title: "Adı", icon: "person", systemIcon: true)
        email.setTitleAndIcon(title: "Mail Adresi", icon: "envelope", systemIcon: true)
        phone.setTitleAndIcon(title: "Telefon Numarası", icon: "phone", systemIcon: true)
        address.setTitleAndIcon(title: "Adres", icon: "location", systemIcon: true)
        desc.setTitleAndIcon(title: "Detay", icon: "doc.text", systemIcon: true)
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
            try establishDate.validatedText(validationType: ValidatorType.zooEstablishDate)
            try name.validatedText(validationType: ValidatorType.zooName)
            try email.validatedText(validationType: ValidatorType.zooMailAddress)
            try phone.validatedText(validationType: ValidatorType.zooPhoneNumber)
            try address.validatedText(validationType: ValidatorType.zooAddress)
            try desc.validatedText(validationType: ValidatorType.zooDescription)

            post()

        } catch {
            Alert.showAlert(message: (error as! ValidationError).message, vc: self)
        }
    }

    // MARK: Data Preparation and POST request

    func post() {
        // prepare paramaters
        let parameters = ["id": "2e502411-b76b-4948-bfd3-dde86d3272ac",
                          "olusmaTarihi": nil,
                          "olusturanKullanici": nil,
                          "sonGuncellenmeTarihi": nil,
                          "establishDate": 1_575_158_400_000,
                          "name": name.text!,
                          "address": address.text!,
                          "workers": "",
                          "description": desc.text!,
                          "phone": phone.text!,
                          "email": email.text!,
                          "workerCount": workers.text!] as [String: Any?]

        // POST request
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in

            // debug
            debugPrint(response)

            // check result is success or failure
            switch response.result {
            case .success:

                // refresh Vet List on previous screen
                Alert.showAlertThenPreviousScreen(message: "Hayvanat Bahçesi başarıyla eklendi!", vc: self)

            case .failure:

                // show warning to user
                print(response.error!)
                Alert.showAlert(message: "Hayvanat Bahçesi eklenirken hata oluştu. Lütfen tekrar deneyiniz!", vc: self)
            }
        }
    }
}
