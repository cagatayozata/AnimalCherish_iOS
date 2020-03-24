//
//  ShelterViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ShelterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/shelter/getall"
    
    var shelterIdArr = [String]()
    var shelterNameArr = [String]()
    var shelterEmailArr = [String]()
    var shelterPhoneArr = [String]()
        
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        getShelterList()
        
    }
    
    // MARK: Data Preparation and GET request
    func getShelterList() {
        
        // show loading indicator
        loadingIndicator()
        
        AF.request(apiUrl, method: .get).responseJSON { (myresponse) in
            
            // check result is success or failure
            switch myresponse.result {
            case .success:
                
                // removeAll
                self.shelterIdArr.removeAll()
                self.shelterNameArr.removeAll()
                self.shelterEmailArr.removeAll()
                self.shelterPhoneArr.removeAll()
                
                // GET data
                let myresult = try? JSON(data: myresponse.data!)
                let resultArray = myresult!
                
                //
                for item in resultArray.arrayValue {

                    let id = item["id"].stringValue
                    let name = item["name"].stringValue
                    let email = item["email"].stringValue
                    let phone = item["phone"].stringValue
                    
                    self.shelterIdArr.append(id)
                    self.shelterNameArr.append(name)
                    self.shelterEmailArr.append(email)
                    self.shelterPhoneArr.append(phone)
                    
                }
                
                // reload table data
                self.tableView.reloadData()
                
                // close loading indicator
                self.dismiss(animated: false, completion: nil)
                
                break
            case .failure:
                
                // close loading indicator
                self.dismiss(animated: false, completion: nil)
                
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
        return shelterIdArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "animalcell")
         if cell == nil {
             cell = UITableViewCell(style: .subtitle, reuseIdentifier: "animalcell")
         }
         
        cell?.textLabel?.text = self.shelterNameArr[indexPath.row]
        cell?.detailTextLabel?.text = (self.shelterEmailArr[indexPath.row] ) + ", " + (self.shelterPhoneArr[indexPath.row] )
        
         return cell!
        
    }

}
