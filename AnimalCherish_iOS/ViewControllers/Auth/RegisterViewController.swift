//
//  RegisterViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var box: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var alreadyRegisterdButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Box
        box.layer.cornerRadius = 15
        box.layer.borderWidth = 1
        
        // Username
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Kullanıcı Adı",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        usernameTextField.setLeftImage(imageName: "person")
        
        // E-mail
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        emailTextField.setLeftImage(imageName: "envelope")
        
        // Password
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Parola",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        passwordTextField.setLeftImage(imageName: "lock")
        
        // Login Button
        registerButton.layer.cornerRadius = 5
        registerButton.layer.borderWidth = 1
        
        // Already Registered Button
        let attributedString = NSAttributedString(string: NSLocalizedString("Zaten üyeyim, giriş yap", comment: ""), attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0),
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.underlineStyle:1.0
        ])
        alreadyRegisterdButton.setAttributedTitle(attributedString, for: .normal)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        // when clicking the UIView, keyboard will be removed
        self.view.endEditing(true)
    
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}

