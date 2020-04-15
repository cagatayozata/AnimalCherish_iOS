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

struct shelterStruct {
    let id : String!
    let name : String!
    let email : String!
    let phone : String!
}

class ShelterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // MARK: IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    let apiUrl = Configuration.apiUrl + "/api/v1/shelter/getall"
    
    var shelters = [shelterStruct]()
    lazy var filteredData = self.shelters
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        
        getShelterList()
        
    }
    
    // MARK: Data Preparation and GET request
    func getShelterList() {
        
        // show loading indicator
        self.showLoadingIndicator(onView: self.view)
        
        AF.request(apiUrl, method: .get).responseJSON { (myresponse) in
            
            // check result is success or failure
            switch myresponse.result {
            case .success:
                
                // GET data
                let myresult = try? JSON(data: myresponse.data!)
                let resultArray = myresult!
                
                //
                for item in resultArray.arrayValue {
                    
                    let id = item["id"].stringValue
                    let name = item["name"].stringValue
                    let email = item["email"].stringValue
                    let phone = item["phone"].stringValue
                    
                    self.shelters.insert(shelterStruct(id: id, name: name, email: email, phone: phone), at: 0)
                    
                }
                
                // prepare filtered data
                self.filteredData = self.shelters
                
                // reload table data
                self.tableView.reloadData()
                
                // remove loading indicator
                self.removeLoadingIndicator()
                
                break
            case .failure:
                
                // remove loading indicator
                self.removeLoadingIndicator()
                
                // show error
                Alert.showAlert(message: "Bir hata oluştu. Barınak Hekim Listesi Getiriemedi!", vc: self)
                break
                
            }
            
        }
    }
    
    // MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "animalcell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "animalcell")
        }
        
        cell?.textLabel?.text = self.filteredData[indexPath.row].name
        cell?.detailTextLabel?.text = (self.filteredData[indexPath.row].email ) + ", " + (self.filteredData[indexPath.row].phone )
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = storyboard?.instantiateViewController(identifier: "goToDetailShelterScreen") as? DetailShelterViewController {
            viewController.selectedId = self.filteredData[indexPath.row].id
            navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    // MARK: UISearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData = self.shelters.filter({ $0.name
            .hasPrefix(searchText) })
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        self.filteredData = self.shelters
        self.tableView.reloadData()
    }
    
}
