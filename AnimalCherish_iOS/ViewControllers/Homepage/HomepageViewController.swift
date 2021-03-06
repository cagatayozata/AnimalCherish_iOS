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

    @IBOutlet var animalButton: UIButton!
    @IBOutlet var vetButton: UIButton!
    @IBOutlet var shelterButton: UIButton!
    @IBOutlet var petShopButton: UIButton!
    @IBOutlet var zooButton: UIButton!

    // MARK: Variables

    var selectedId: String?

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

    // MARK: Logout

    func logout(_: Any) {
        UserDefaults.standard.set(false, forKey: "status")
    }

    // MARK: goBackToFirst

    @IBAction func goBackToHomepage(_: UIStoryboardSegue) {}
}
