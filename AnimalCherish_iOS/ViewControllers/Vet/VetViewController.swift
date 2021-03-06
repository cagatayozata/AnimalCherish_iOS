//
//  VetViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

struct vetStruct {
    let id: String!
    let name: String!
    let city: String!
    let state: String!
    let clinicInfo: String!
}

class VetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    // MARK: IBOutlet

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    // MARK: Variables

    let apiUrl = Configuration.apiUrl + "/api/v1/vet/getall"

    var vets = [vetStruct]()
    lazy var filteredData = self.vets

    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        getVetlist()
    }

    // MARK: Data Preparation and GET request

    func getVetlist() {
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
                    let clinic = item["clinic"].stringValue
                    let state = item["ilce"].stringValue
                    let city = item["city"].stringValue

                    self.vets.insert(vetStruct(id: id, name: name, city: city, state: state, clinicInfo: clinic), at: 0)
                }

                // prepare filtered data
                self.filteredData = self.vets

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
                Alert.showAlert(message: "Bir hata oluştu. Veteriner Hekim Listesi Getiriemedi!", vc: self)
            }
        }
    }

    // MARK: UITableView

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "vetcell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "vetcell")
        }

        cell?.textLabel?.text = filteredData[indexPath.row].name
        cell?.detailTextLabel?.text = filteredData[indexPath.row].clinicInfo + ", " + filteredData[indexPath.row].state + ", " + filteredData[indexPath.row].city

        return cell!
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(identifier: "goToEditVetScreen") as? DetailVetViewController {
            viewController.selectedId = filteredData[indexPath.row].id
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    // MARK: UISearchBar

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        filteredData = vets.filter { $0.name
            .hasPrefix(searchText)
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        filteredData = vets
        tableView.reloadData()
    }
}
