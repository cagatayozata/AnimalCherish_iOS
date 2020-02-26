//
//  MainViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class AnimalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var animals: [String] = ["İsimsiz", "Pulsar", "İsimsiz", "tretet"]
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = self.animals[indexPath.row]
        
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
