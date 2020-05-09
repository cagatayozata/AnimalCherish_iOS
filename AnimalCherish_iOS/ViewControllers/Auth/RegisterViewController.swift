//
//  RegisterViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: IBOutlet

    @IBOutlet var box: UIView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var alreadyRegisterdButton: UIButton!

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

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        // when clicking the UIView, keyboard will be removed
        view.endEditing(true)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification _: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }

    // MARK: style

    func style() {
        // Box
        box.layer.cornerRadius = 15
        box.layer.borderWidth = 1

        // Username
        usernameTextField.setTitleAndIcon(title: "Kullanıcı Adı", icon: "person", systemIcon: true)

        // E-mail
        emailTextField.setTitleAndIcon(title: "Email", icon: "envelope", systemIcon: true)

        // Password
        passwordTextField.setTitleAndIcon(title: "Parola", icon: "lock", systemIcon: true)

        // Login Button
        registerButton.layer.cornerRadius = 5
        registerButton.layer.borderWidth = 1

        // Already Registered Button
        alreadyRegisterdButton.setLoginButton(title: "Zaten üyeyim, giriş yap")
    }
}
