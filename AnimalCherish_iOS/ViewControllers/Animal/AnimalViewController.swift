//
//  MainViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AnimalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/animal/getall"
    
    var animalIdArr = [String]()
    var animalNameArr = [String]()
    var animalTypeArr = [String]()
    var animalGenusArr = [String]()
        
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        getAnimalList()
        
    }
    
    // MARK: Data Preparation and GET request
    func getAnimalList() {
        
        AF.request(apiUrl, method: .get).responseJSON { (myresponse) in
            
            // check result is success or failure
            switch myresponse.result {
            case .success:
                
                // removeAll
                self.animalIdArr.removeAll()
                self.animalNameArr.removeAll()
                self.animalTypeArr.removeAll()
                self.animalGenusArr.removeAll()
                
                // GET data
                let myresult = try? JSON(data: myresponse.data!)
                let resultArray = myresult!
                
                //
                for item in resultArray.arrayValue {

                    let id = item["id"].stringValue
                    let name = item["name"].stringValue
                    let type = item["turAd"].stringValue
                    let genus = item["cinsAd"].stringValue
                    
                    self.animalIdArr.append(id)
                    self.animalNameArr.append(name)
                    self.animalTypeArr.append(type)
                    self.animalGenusArr.append(genus)
                    
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
        return animalIdArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "animalcell")
         if cell == nil {
             cell = UITableViewCell(style: .subtitle, reuseIdentifier: "animalcell")
         }
         
        cell?.textLabel?.text = self.animalNameArr[indexPath.row]
        cell?.detailTextLabel?.text = (self.animalTypeArr[indexPath.row] ) + ", " + (self.animalGenusArr[indexPath.row] )
        
         return cell!
        
    }

}
