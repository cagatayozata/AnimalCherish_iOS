//
//  DeatilAnimalViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 10.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

class DeatilAnimalViewController: UIViewController {
    // MARK: IBOutlet

    @IBOutlet var IdTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var genusTextField: UITextField!
    @IBOutlet var genderTextField: UITextField!

    // MARK: Variables

    let apiUrl = Configuration.apiUrl + "/api/v1/animal/getall"

    var selectedId: String?

    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        // style textfields and buttons
        style()

        // disable text fields
        disableEditing()

        // check nil
        if selectedId != nil {
            getAnimalDetail()
        } else {
            Alert.showAlert(message: "Hata Oluştu! Lütfen geri dönünüz!", vc: self)
        }
    }

    // MARK: GET request and Prepare Selected Data

    func getAnimalDetail() {
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
                        let id = item["id"].stringValue
                        let name = item["name"].stringValue
                        let location = item["address"].stringValue
                        let type = item["turAd"].stringValue
                        let genus = item["cinsAd"].stringValue
                        var gender = item["cinsiyet"].stringValue

                        if gender == "true" {
                            gender = "Erkek"
                        } else {
                            gender = "Dişi"
                        }

                        self.IdTextField.text! = id
                        self.nameTextField.text! = name
                        self.locationTextField.text! = location
                        self.typeTextField.text! = type
                        self.genusTextField.text! = genus
                        self.genderTextField.text! = gender
                    }

                    i = i + 1
                }

            case .failure:
                Alert.showAlert(message: "Bir hata oluştu. Hayvan Listesi Getiriemedi!", vc: self)
                print(myresponse.error!)
            }
        }
    }

    // MARK: Send selectedId to EditAnimalViewController

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "goEditAnimalScreen" {
            let editAnimalController = segue.destination as? EditAnimalViewController
            if let tempController = editAnimalController {
                tempController.selectedId = selectedId
            }
        }
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

    // MARK: style

    func style() {
        // TextField Style
        IdTextField.setTitleAndIcon(title: "Küpe Numarası", icon: "star", systemIcon: true)
        nameTextField.setTitleAndIcon(title: "Hayvan Adı", icon: "person", systemIcon: true)
        locationTextField.setTitleAndIcon(title: "Konum", icon: "location", systemIcon: true)
        typeTextField.setTitleAndIcon(title: "Tür", icon: "tortoise", systemIcon: true)
        genusTextField.setTitleAndIcon(title: "Cins", icon: "tortoise", systemIcon: true)
        genderTextField.setTitleAndIcon(title: "Cinsiyet", icon: "info", systemIcon: true)
    }
}
