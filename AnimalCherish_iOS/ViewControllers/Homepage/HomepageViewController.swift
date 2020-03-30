//
//  HomepageViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 30.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {

    @IBOutlet weak var animalButton: UIButton!
    @IBOutlet weak var vetButton: UIButton!
    @IBOutlet weak var shelterButton: UIButton!
    @IBOutlet weak var petShopButton: UIButton!
    @IBOutlet weak var zooButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Animal Button
        var icon = UIImage(systemName: "person")!
        animalButton.setImage(icon, for: .normal)
        animalButton.imageView?.contentMode = .scaleAspectFit
        animalButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        animalButton.tintColor = .white
        animalButton.layer.cornerRadius = 30
        animalButton.layer.borderWidth = 1
        
        // Animal Button
        icon = UIImage(systemName: "person")!
        vetButton.setImage(icon, for: .normal)
        vetButton.imageView?.contentMode = .scaleAspectFit
        vetButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        vetButton.tintColor = .white
        vetButton.layer.cornerRadius = 30
        vetButton.layer.borderWidth = 1
        
        // Animal Button
        icon = UIImage(systemName: "person")!
        shelterButton.setImage(icon, for: .normal)
        shelterButton.imageView?.contentMode = .scaleAspectFit
        shelterButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        shelterButton.tintColor = .white
        shelterButton.layer.cornerRadius = 30
        shelterButton.layer.borderWidth = 1
        
        // Animal Button
        icon = UIImage(systemName: "person")!
        petShopButton.setImage(icon, for: .normal)
        petShopButton.imageView?.contentMode = .scaleAspectFit
        petShopButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        petShopButton.tintColor = .white
        petShopButton.layer.cornerRadius = 30
        petShopButton.layer.borderWidth = 1
        
        // Animal Button
        icon = UIImage(systemName: "person")!
        zooButton.setImage(icon, for: .normal)
        zooButton.imageView?.contentMode = .scaleAspectFit
        zooButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        zooButton.tintColor = .white
        zooButton.layer.cornerRadius = 30
        zooButton.layer.borderWidth = 1
        
    }
    
    // MARK: goBackToFirst
    @IBAction func goBackToHomepage(_ sender: UIStoryboardSegue) {
    }

}
