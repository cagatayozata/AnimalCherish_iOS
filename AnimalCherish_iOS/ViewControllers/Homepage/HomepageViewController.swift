//
//  HomepageViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 30.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var animalButton: UIButton!
    @IBOutlet weak var vetButton: UIButton!
    @IBOutlet weak var shelterButton: UIButton!
    @IBOutlet weak var petShopButton: UIButton!
    @IBOutlet weak var zooButton: UIButton!
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // style textfields and buttons
        style()
        
    }
    
    func style() {
        
        animalButton.setHomepageButton(imageName: "person")
        vetButton.setHomepageButton(imageName: "person")
        shelterButton.setHomepageButton(imageName: "person")
        petShopButton.setHomepageButton(imageName: "person")
        zooButton.setHomepageButton(imageName: "person")
        
    }
    
    // MARK: goBackToFirst
    @IBAction func goBackToHomepage(_ sender: UIStoryboardSegue) {
    }
    
}
