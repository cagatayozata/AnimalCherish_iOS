//
//  ZooViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Alamofire
import SwiftyJSON
import UIKit

struct zooStruct {
    let id: String!
    let name: String!
    let address: String!
    let phone: String!
}

class ZooViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    // MARK: IBOutlet

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    // MARK: Variables

    let apiUrl = Configuration.apiUrl + "/api/v1/zoo/getall"

    var zoos = [zooStruct]()
    lazy var filteredData = self.zoos

    // MARK: viewDownload

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        getZooList()
    }

    // MARK: Data Preparation and GET request

    func getZooList() {
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
                    let address = item["address"].stringValue
                    let phone = item["phone"].stringValue

                    self.zoos.insert(zooStruct(id: id, name: name, address: address, phone: phone), at: 0)
                }

                // prepare filtered data
                self.filteredData = self.zoos

                // reload table data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

                // remove loading indicator
                self.removeLoadingIndicator()

            case .failure:
                Alert.showAlert(message: "Bir hata oluştu. Hayvanat Bahçesi Listesi Getiriemedi!", vc: self)
                print(myresponse.error!)
            }
        }
    }

    // MARK: UITableView

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "zoocell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "zoocell")
        }

        cell?.textLabel?.text = filteredData[indexPath.row].name
        cell?.detailTextLabel?.text = filteredData[indexPath.row].address + ", " + filteredData[indexPath.row].phone

        return cell!
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = storyboard?.instantiateViewController(identifier: "goToEditZooScreen") as? DetailZooViewController {
            viewController.selectedId = filteredData[indexPath.row].id
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    // MARK: UISearchBar

    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        filteredData = zoos.filter { $0.name
            .hasPrefix(searchText)
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        filteredData = zoos
        tableView.reloadData()
    }
}
