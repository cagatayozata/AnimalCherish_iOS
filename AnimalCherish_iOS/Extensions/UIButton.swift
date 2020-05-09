//
//  UIButton.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 2.04.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Foundation
import UIKit

// homepage button style
extension UIButton {
    func setHomepageButton(imageName: String) {
        var icon = UIImage(systemName: imageName)!
        setImage(icon, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        tintColor = .white
        layer.cornerRadius = 30
        layer.borderWidth = 1
    }

    func setLoginButton(title: String) {
        let attributedString = NSAttributedString(string: NSLocalizedString(title, comment: ""), attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.underlineStyle: 1.0,
        ])
        setAttributedTitle(attributedString, for: .normal)
    }

    func setRegisterButton(title: String) {
        let attributedString = NSAttributedString(string: NSLocalizedString(title, comment: ""), attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.underlineStyle: 1.0,
        ])
        setAttributedTitle(attributedString, for: .normal)
    }
}
