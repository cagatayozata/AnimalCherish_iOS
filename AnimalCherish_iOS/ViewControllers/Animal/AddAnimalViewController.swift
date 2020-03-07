//
//  AddAnimalViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 7.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class AddAnimalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var genusTextField: UITextField!
    
    let types = ["test1", "test2", "test3"]
    let genus = ["test0"]
    
    var typePickerView = UIPickerView()
    var genusPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        typePickerView.delegate = self
        typePickerView.dataSource = self
        
        genusPickerView.delegate = self
        genusPickerView.dataSource = self
        
        typeTextField.inputView = typePickerView
        genusTextField.inputView = genusPickerView
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        print("ID: " + IdTextField.text!)
        print("Name: " + nameTextField.text!)
        print("Location: " + locationTextField.text!)
        print("Type: " + typeTextField.text!)
        print("Genus: " + genusTextField.text!)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if self.typeTextField.isEditing {
            return types.count
        } else {
            return genus.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if self.typeTextField.isEditing {
            return types[row]
        } else {
            return genus[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if self.typeTextField.isEditing {
            typeTextField.text = types[row]
            typeTextField.resignFirstResponder()
        } else {
            genusTextField.text = genus[row]
            genusTextField.resignFirstResponder()
        }
        
    }

}
