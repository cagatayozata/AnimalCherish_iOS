//
//  VetViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  // MARK: IBOutlet
     @IBOutlet weak var tableView: UITableView!
     
     // MARK: Variables
     let apiUrl = Configuration.apiUrl + "/api/v1/vet/getall"
     
     var vetIdArr = [String]()
     var vetNameArr = [String]()
     var vetWorkPlaceArr = [String]()
     var vetCityArr = [String]()
     var vetStateArr = [String]()
     var vetClinicInfoArr = [String]()
     var vetPhoneArr = [String]()
     var vetEmailArr = [String]()
     var vetBirthDateArr = [String]()
    
     // MARK: viewDidLoad
     override func viewDidLoad() {
         super.viewDidLoad()
         self.tableView.delegate = self as! UITableViewDelegate
         self.tableView.dataSource = self as! UITableViewDataSource
     }

    // MARK: Data Preparation and GET request
    func getAnimalList() {
        
        AF.request(apiUrl, method: .get).responseJSON { (myresponse) in
            
            // check result is success or failure
            switch myresponse.result {
            case .success:
                
                // removeAll
                self.vetIdArr.removeAll()
                self.vetNameArr.removeAll()
                self.vetCityArr.removeAll()
                self.vetStateArr.removeAll()
                self.vetClinicInfoArr.removeAll()
                
                // GET data
                let myresult = try? JSON(data: myresponse.data!)
                let resultArray = myresult!
                
                //
                for item in resultArray.arrayValue {

                    let id = item["id"].stringValue
                    let name = item["name"].stringValue
                    let clinic = item["clinic"].stringValue
                    let state = item["ilce"].stringValue
                    let city = item["city"].stringValue
                    
                    self.vetIdArr.append(id)
                    self.vetNameArr.append(name)
                    self.vetClinicInfoArr.append(clinic)
                    self.vetStateArr.append(state)
                    self.vetCityArr.append(city)
                    
                }
                // reload table data
                self.tableView.reloadData()
                
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
     
     // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vetIdArr.count
    }
    
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
         var cell = tableView.dequeueReusableCell(withIdentifier: "vetcell")
          if cell == nil {
              cell = UITableViewCell(style: .subtitle, reuseIdentifier: "vetcell")
          }
          
         cell?.textLabel?.text = self.vetNameArr[indexPath.row]
         cell?.detailTextLabel?.text = (self.vetWorkPlaceArr[indexPath.row] ) + ", " + (self.vetWorkPlaceArr[indexPath.row] )
         
          return cell!
         
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
         var selectedId = indexPath.row

         if let viewController = storyboard?.instantiateViewController(identifier: "goToEditVetScreen") as? DetailVetViewController {
             viewController.selectedId = selectedId
             navigationController?.pushViewController(viewController, animated: true)
         }
     }
}
