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
        
        animalButton.setHomepageButton(imageName: "tortoise.fill")
        vetButton.setHomepageButton(imageName: "person.fill")
        shelterButton.setHomepageButton(imageName: "house.fill")
        petShopButton.setHomepageButton(imageName: "person.2.square.stack.fill")
        zooButton.setHomepageButton(imageName: "chevron.up")
        
    }
    
    // MARK: goBackToFirst
    @IBAction func goBackToHomepage(_ sender: UIStoryboardSegue) {
    }
    
}
