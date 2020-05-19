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
import WebKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    // MARK: IBOutlet

    @IBOutlet var box: UIView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var forgetPasswordButton: UIButton!
    @IBOutlet var createUserButton: UIButton!
    @IBOutlet var forgotPasswordBtn: UIButton!

    // MARK: Variables

    let apiUrl = Configuration.apiUrl + "/api/v1/kullanici/getall"
    var selectedId: String?
    var iDs: [String] = []
    var enteredEmail: String?
    var enteredpassword: String?
    var enteredPass: String?
    var emails: [String] = []
    var userPasswords: [String] = []

    var login_session: Data?
    var login_url: String = ""
    let checksession_url: String = ""
    var sessions_data: Data?

    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        enteredPass = sha256(str: passwordTextField.text!)

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        // Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        passwordTextField.isSecureTextEntry = true

        // style edits
        style()

        getUser()
    }

    func login_now(username: String, password: String) {
        let post_data: NSDictionary = NSMutableDictionary()

        post_data.setValue(username, forKey: "username")
        post_data.setValue(password, forKey: "password")

        let url: URL = URL(string: login_url)!
        let session = URLSession.shared

        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData

        var paramString = ""

        for (key, value) in post_data {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }

        request.httpBody = paramString.data(using: String.Encoding.utf8)

        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in

            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                return
            }

            let json: Any?

            do {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            } catch {
                return
            }

            guard let server_response = json as? NSDictionary else {
                return
            }

            if let data_block = server_response["data"] as? NSDictionary {
                if let session_data = data_block["session"] as? String {
                    self.login_session = self.sessions_data

                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                }
            }

        })

        task.resume()
    }

    // MARK: prepare to send selectedId

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "loginSegue" {
            let loginController = segue.destination as? HomepageViewController
            if let tempController = loginController {
                tempController.selectedId = selectedId
                print("User ID ", selectedId)
            }
        }
    }

    // MARK: Password Hashing to match SHA256 standards

    func sha256(str: String) -> String {
        if let strData = str.data(using: String.Encoding.utf8) {
            /// #define CC_SHA256_DIGEST_LENGTH     32
            /// Creates an array of unsigned 8 bit integers that contains 32 zeros
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))

            /// CC_SHA256 performs digest calculation and places the result in the caller-supplied buffer for digest (md)
            /// Takes the strData referenced value (const unsigned char *d) and hashes it into a reference to the digest parameter.
            strData.withUnsafeBytes {
                // CommonCrypto
                // extern unsigned char *CC_SHA256(const void *data, CC_LONG len, unsigned char *md)  -|
                // OpenSSL                                                                             |
                // unsigned char *SHA256(const unsigned char *d, size_t n, unsigned char *md)        <-|
                CC_SHA256($0.baseAddress, UInt32(strData.count), &digest)
            }

            var sha256String = ""
            /// Unpack each byte in the digest array and add them to the sha256String
            for byte in digest {
                sha256String += String(format: "%02x", UInt8(byte))
            }

            // MARK: To test / Debug

            if sha256String.uppercased() == "E8721A6EBEA3B23768D943D075035C7819662B581E487456FDB1A7129C769188" {
                print("Matching sha256 hash: E8721A6EBEA3B23768D943D075035C7819662B581E487456FDB1A7129C769188")
            } else {
                print("sha256 hash does not match: \(sha256String)")
            }
            return sha256String
        }
        return ""
    }

    // MARK: Session Control

    func check_session() {
        let post_data: NSDictionary = NSMutableDictionary()

        post_data.setValue(login_session, forKey: "session")

        let url: URL = URL(string: checksession_url)!
        let session = URLSession.shared

        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData

        var paramString = ""

        for (key, value) in post_data {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }

        request.httpBody = paramString.data(using: String.Encoding.utf8)

        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in

            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                return
            }

            let json: Any?

            do {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            } catch {
                return
            }

            guard let server_response = json as? NSDictionary else {
                return
            }

              })

        task.resume()
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

                    self.iDs.append(id)
                    self.emails.append(email)
                    self.userPasswords.append(password)
                }

                //  print(self.emails, self.userPasswords)
                //  remove loading indicator
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

    // MARK: Register

    @IBAction func createUserAction(_: Any) {
        if let url = NSURL(string: "http://138.68.67.165/register.jsf") {
            UIApplication.shared.open(url as URL)
        }
    }

    // MARK: Forgot Password

    @IBAction func forgotPasswordAction(_: Any) {
        if let url = NSURL(string: "http://138.68.67.165/sifre_sifirla.jsf") {
            UIApplication.shared.open(url as URL)
        }
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

    // MARK: Keyboard hide

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
