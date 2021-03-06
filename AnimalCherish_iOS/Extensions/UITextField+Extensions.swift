//
//  UITextField+Extensions.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 7.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit.UITextField

// validation for textfield
extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(text!)
    }
}

// set icon to text fields
extension UITextField {
    func setTitleAndIcon(title: String, icon: String, systemIcon: Bool) {
        attributedPlaceholder = NSAttributedString(string: title,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])

        let leftImageView = UIImageView()
        if systemIcon {
            leftImageView.image = UIImage(systemName: icon)
        } else {
            leftImageView.image = UIImage(named: icon)
        }

        let leftView = UIView()
        leftView.addSubview(leftImageView)

        leftView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        leftImageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)

        leftViewMode = .always
        self.leftView = leftView
    }
}
