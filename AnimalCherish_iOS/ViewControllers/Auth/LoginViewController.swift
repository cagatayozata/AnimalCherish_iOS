//
//  LoginViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Alamofire
import typealias CommonCrypto.CC_LONG
import func CommonCrypto.CC_MD5
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_SHA256
import var CommonCrypto.CC_SHA256_DIGEST_LENGTH
import CryptoKit
import Foundation
import SwiftyJSON
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    // MARK: IBOutlet

    @IBOutlet var box: UIView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var forgetPasswordButton: UIButton!
    @IBOutlet var createUserButton: UIButton!

    // MARK: Variables

    let apiUrl = Configuration.apiUrl + "/api/v1/kullanici/getall"
    var selectedId: String?
    var enteredEmail: String?
    var enteredpassword: String?
    var emails: [String] = []
    var userPasswords: [String] = []

    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        // Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // style edits
        style()

        getUser()
    }

    // MARK: Find user

    func getUser() {
        // MARK: show loading indicator

        showLoadingIndicator(onView: view)

        AF.request(apiUrl, method: .get).responseJSON { myresponse in

            // MARK: check result is success or failure

            switch myresponse.result {
            case .success:

                // MARK: GET data

                let myresult = try? JSON(data: myresponse.data!)
                let resultArray = myresult!

                // MARK: Insert JSON Values

                for item in resultArray.arrayValue {
                    let id = item["id"].stringValue
                    let email = item["email"].stringValue
                    let password = item["password"].stringValue

                    self.selectedId = id
                    self.emails.append(email)
                    self.userPasswords.append(password)
                }

                print(self.emails, self.userPasswords)
                // remove loading indicator
                self.removeLoadingIndicator()

            case .failure:

                // MARK: Show error

                // remove loading indicator
                self.removeLoadingIndicator()

                Alert.showAlert(message: "Kullanıcılar getirilemedi !", vc: self)
            }
        }
    }

    // MARK: LOGIN

    func login() {
        var count = 0

        print("passss")
        print(enteredpassword)

        if enteredEmail!.isEmpty || enteredpassword!.isEmpty {
            Alert.showAlert(message: "Email veya Parola boş bırakılamaz !", vc: self)
        } else {
            for mail in emails {
                if enteredEmail == mail {
                    if enteredpassword == userPasswords[count] {
                        performSegue(withIdentifier: "loginSegue", sender: self)
                    } else {
                        Alert.showAlert(message: "Email veya Parola Yanlış", vc: self)
                    }
                }
                count += 1
            }
        }
    }

    // MARK: Login Button

    @IBAction func loginButtonAction(_: Any) {
        enteredEmail = usernameTextField.text

       
        enteredpassword = md5Hash(str: passwordTextField.text!)
        login()
    }

    // MARK: prepare to send selectedId

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "loginSegue" {
            let loginController = segue.destination as? HomepageViewController
            if let tempController = loginController {
                tempController.selectedId = selectedId
            }
        }
    }

    // MARK: Password Hashing to match MD5 standards

    func ccSha256(data: Data) -> Data {
        var digest = Data(count: Int(CC_SHA256_DIGEST_LENGTH))

        _ = digest.withUnsafeMutableBytes { digestBytes in
            data.withUnsafeBytes { stringBytes in
                CC_SHA256(stringBytes, CC_LONG(data.count), digestBytes)
            }
        }
        return digest
    }

    // MARK: Keyboard Disapper touches on the screen

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        // when clicking the UIView, keyboard will be removed
        view.endEditing(true)
    }

    // MARK: Keyboard show

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

    // MARK: style()

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

    // MARK: Password Hashing to match MD5 standards

    func md5Hash(str: String) -> String {
        if let strData = str.data(using: String.Encoding.utf8) {
            /// #define CC_MD5_DIGEST_LENGTH    16          /* digest length in bytes */
            /// Creates an array of unsigned 8 bit integers that contains 16 zeros
            var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))

            /// CC_MD5 performs digest calculation and places the result in the caller-supplied buffer for digest (md)
            /// Calls the given closure with a pointer to the underlying unsafe bytes of the strData’s contiguous storage.
            strData.withUnsafeBytes {
                // CommonCrypto
                // extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md) --|
                // OpenSSL                                                                          |
                // unsigned char *MD5(const unsigned char *d, size_t n, unsigned char *md)        <-|
                CC_MD5($0.baseAddress, UInt32(strData.count), &digest)
            }

            var md5String = ""
            /// Unpack each byte in the digest array and add them to the md5String
            for byte in digest {
                md5String += String(format: "%02x", UInt8(byte))
            }

            // MD5 hash check (This is just done for example)

            return md5String
        }
        return ""
    }
}
