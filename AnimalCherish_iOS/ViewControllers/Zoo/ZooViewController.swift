//
//  ZooViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ZooViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/zoo/getall"
    let menuSlide = MenuSlide()
    
    var zooIdArr = [String]()
    var zooNameArr = [String]()
    var zooAddressArr = [String]()
    var zooPhoneArr = [String]()
    
    // MARK: viewDownload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getZooList()
        
        }
    
       // MARK: Data Preparation and GET request
       func getZooList() {
           
           AF.request(apiUrl, method: .get).responseJSON { (myresponse) in
               
               // check result is success or failure
               switch myresponse.result {
               case .success:
                   
                   // removeAll
                   self.zooIdArr.removeAll()
                   self.zooNameArr.removeAll()
                   self.zooAddressArr.removeAll()
                   self.zooPhoneArr.removeAll()
                   
                   // GET data
                   let myresult = try? JSON(data: myresponse.data!)
                   let resultArray = myresult!
                   
                   //
                   for item in resultArray.arrayValue {

                       let id = item["id"].stringValue
                       let name = item["name"].stringValue
                       let address = item["address"].stringValue
                       let phone = item["phone"].stringValue
                       
                       self.zooIdArr.append(id)
                       self.zooNameArr.append(name)
                       self.zooAddressArr.append(address)
                       self.zooPhoneArr.append(phone)
                       
                   }
                   // reload table data
                   self.tableView.reloadData()
                   
                   break
                   case .failure:
                   self.showAlert(for: "Bir hata oluştu. Hayvanat Bahçesi Listesi Getiriemedi!")
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
     
    // MARK: Show Menu
    @IBAction func menuButtonPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController1") as! MenuViewController

        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
        
    }
    
     // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zooIdArr.count
    }
    
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
         var cell = tableView.dequeueReusableCell(withIdentifier: "zoocell")
          if cell == nil {
              cell = UITableViewCell(style: .subtitle, reuseIdentifier: "zoocell")
          }
          
         cell?.textLabel?.text = self.zooNameArr[indexPath.row]
         cell?.detailTextLabel?.text = (self.zooAddressArr[indexPath.row] ) + ", " + (self.zooPhoneArr[indexPath.row] )
         
          return cell!
         
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
         var selectedId = indexPath.row

         if let viewController = storyboard?.instantiateViewController(identifier: "goToEditZooScreen") as? DetailZooViewController {
             viewController.selectedId = selectedId
             navigationController?.pushViewController(viewController, animated: true)
         }
     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
