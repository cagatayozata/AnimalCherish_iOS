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
