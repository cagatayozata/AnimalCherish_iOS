//
//  PetShopViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PetShopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/petshop/getall"
    
    var petShopIdArr = [String]()
    var petShopNameArr = [String]()
    var petShopEmailArr = [String]()
    var petShopPhoneArr = [String]()
        
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        getPetShopList()
        
    }
    
    // MARK: Data Preparation and GET request
    func getPetShopList() {
        
        // show loading indicator
        loadingIndicator()
        
        AF.request(apiUrl, method: .get).responseJSON { (myresponse) in
            
            // check result is success or failure
            switch myresponse.result {
            case .success:
                
                // removeAll
                self.petShopIdArr.removeAll()
                self.petShopNameArr.removeAll()
                self.petShopEmailArr.removeAll()
                self.petShopPhoneArr.removeAll()
                
                // GET data
                let myresult = try? JSON(data: myresponse.data!)
                let resultArray = myresult!
                
                //
                for item in resultArray.arrayValue {

                    let id = item["id"].stringValue
                    let name = item["name"].stringValue
                    let email = item["email"].stringValue
                    let phone = item["phone"].stringValue
                    
                    self.petShopIdArr.append(id)
                    self.petShopNameArr.append(name)
                    self.petShopEmailArr.append(email)
                    self.petShopPhoneArr.append(phone)
                    
                }
                
                // reload table data
                self.tableView.reloadData()
                
                // close loading indicator
                self.dismiss(animated: false, completion: nil)
                
                break
            case .failure:
                self.showAlert(for: "Bir hata oluştu. Hayvan Listesi Getiriemedi!")
                print(myresponse.error!)
                break
            }
    
        }
    }
    
    // MARK: Alert
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Loading Indicator
    func loadingIndicator() {
        
        let alert = UIAlertController(title: nil, message: "Yükleniyor...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petShopIdArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "animalcell")
         if cell == nil {
             cell = UITableViewCell(style: .subtitle, reuseIdentifier: "animalcell")
         }
         
        cell?.textLabel?.text = self.petShopNameArr[indexPath.row]
        cell?.detailTextLabel?.text = (self.petShopEmailArr[indexPath.row] ) + ", " + (self.petShopPhoneArr[indexPath.row] )
        
         return cell!
        
    }

}
