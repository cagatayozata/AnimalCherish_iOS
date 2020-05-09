//
//  ShelterViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

struct shelterStruct {
    let id: String!
    let name: String!
    let email: String!
    let phone: String!
}

class ShelterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    // MARK: IBOutlet

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!

    // MARK: Variables

    let apiUrl = Configuration.apiUrl + "/api/v1/shelter/getall"

    var shelters = [shelterStruct]()
    lazy var filteredData = self.shelters

    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        getShelterList()
    }

    // MARK: Data Preparation and GET request

    func getShelterList() {
        // show loading indicator
        showLoadingIndicator(onView: view)

        AF.request(apiUrl, method: .get).responseJSON { myresponse in

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
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

                // remove loading indicator
                self.removeLoadingIndicator()

            case .failure:

                // remove loading indicator
                self.removeLoadingIndicator()

                // show error
                Alert.showAlert(message: "Bir hata oluştu. Barınak Hekim Listesi Getiriemedi!", vc: self)
            }
        }
    }

    // MARK: UITableView

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "animalcell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "animalcell")
        }

        cell?.textLabel?.text = filteredData[indexPath.row].name
        cell?.detailTextLabel?.text = filteredData[indexPath.row].email + ", " + filteredData[indexPath.row].phone

        return cell!
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(identifier: "goToDetailShelterScreen") as? DetailShelterViewController {
            viewController.selectedId = filteredData[indexPath.row].id
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    // MARK: UISearchBar

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        filteredData = shelters.filter { $0.name
            .hasPrefix(searchText)
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        filteredData = shelters
        tableView.reloadData()
    }
}
