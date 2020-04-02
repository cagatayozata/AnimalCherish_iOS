//
//  LoginViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var createUserButton: UIButton!
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // style edits
        style()
        
    }
    
    // MARK: Keyboard
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
    
    // MARK: style
    func style() {
        
        // Box
        box.layer.cornerRadius = 15
        box.layer.borderWidth = 1
        
        // Username
        usernameTextField.setTitleAndIcon(title: "Kullanıcı Adı", icon: "person", systemIcon: true)
        
        // Password
        passwordTextField.setTitleAndIcon(title: "Parola", icon: "lock", systemIcon: true)
        
        // Login Button
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        
        // Forget Password
        forgetPasswordButton.setLoginButton(title: "Şifremi Unuttum")
        
        // Create an account
        createUserButton.setLoginButton(title: "Hesap Oluştur")
        
    }
    
}
