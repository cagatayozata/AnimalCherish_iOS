//
//  PetShopViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

struct petShopStruct {
    let id: String!
    let name: String!
    let email: String!
    let phone: String!
}

class PetShopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    // MARK: IBOutlet

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UITableView!

    // MARK: Variables

    let apiUrl = Configuration.apiUrl + "/api/v1/petshop/getall"

    var petShops = [petShopStruct]()
    lazy var filteredData = self.petShops

    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        getPetShopList()
    }

    // MARK: Data Preparation and GET request

    func getPetShopList() {
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

                    self.petShops.insert(petShopStruct(id: id, name: name, email: email, phone: phone), at: 0)
                }

                // prepare filtered data
                self.filteredData = self.petShops

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
                Alert.showAlert(message: "Bir hata oluştu. Pet Shop Listesi Getiriemedi!", vc: self)
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
        if let viewController = storyboard?.instantiateViewController(identifier: "goToPetShopDetailScreen") as? DetailPetShopViewController {
            viewController.selectedId = filteredData[indexPath.row].id
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    // MARK: UISearchBar

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        filteredData = petShops.filter { $0.name
            .hasPrefix(searchText)
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        filteredData = petShops
        tableView.reloadData()
    }
}
