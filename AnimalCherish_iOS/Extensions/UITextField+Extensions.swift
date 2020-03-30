//
//  UITextField+Extensions.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 7.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit.UITextField

extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}

extension UITextField{

    func setLeftImage(imageName:String) {

        let leftImageView = UIImageView()
        leftImageView.image = UIImage(systemName: imageName)

        let leftView = UIView()
        leftView.addSubview(leftImageView)

        leftView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        leftImageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)

        self.leftViewMode = .always
        self.leftView = leftView
        
    }
}
