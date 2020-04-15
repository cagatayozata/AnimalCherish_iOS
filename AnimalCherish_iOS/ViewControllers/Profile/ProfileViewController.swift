//
//  ProfileViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 30.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var role: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TextField Style
        name.setTitleAndIcon(title: "İsim", icon: "person", systemIcon: true)
        surname.setTitleAndIcon(title: "Soyad", icon: "person", systemIcon: true)
        role.setTitleAndIcon(title: "Rol", icon: "rosette", systemIcon: true)
        mail.setTitleAndIcon(title: "Mail Adresi", icon: "envelope", systemIcon: true)
        phone.setTitleAndIcon(title: "Telefon Numarası", icon: "phone", systemIcon: true)
        
        // Image Style
        image?.layer.cornerRadius = (image?.frame.size.width ?? 0.0) / 2
        image?.clipsToBounds = true
        image?.layer.borderWidth = 3.0
        image?.layer.borderColor = #colorLiteral(red: 0.0006258591893, green: 0.4516738057, blue: 0.96962744, alpha: 1)
        
    }


}
