//
//  MenuViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 25.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var closeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // close
        closeImage.isUserInteractionEnabled = true
        
        // image
        image?.layer.cornerRadius = (image?.frame.size.width ?? 0.0) / 2
        image?.clipsToBounds = true
        image?.layer.borderWidth = 3.0
        image?.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //
        nameLabel.text! = "Çağatay ÖZATA"
        usernameLabel.text! = "Veteriner Hekim"
    }

    @IBAction func closePressed(_ sender: Any) {
        
        dismiss(animated: true)
        
    }
    
}
