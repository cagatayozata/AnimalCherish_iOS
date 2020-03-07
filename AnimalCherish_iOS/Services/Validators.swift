//
//  Validators.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 7.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case animalId
    case animalName
    case location
    case animalType
    case animalGenus
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .animalId: return AnimalIdValidator()
        case .animalName: return AnimalNameValidator()
        case .location: return LocationValidator()
        case .animalType: return AnimalTypeValidator()
        case .animalGenus: return AnimalGenusValidator()
        }
    }
}

class AnimalIdValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Küpe numarası alanı zorunludur!")}
        guard let age = Int(value) else {throw ValidationError("Küpe numarası sadece rakamlardan oluşabilir!")}
        return value
    }
}

struct AnimalNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Hayvan ismi alanı zorunludur!")}
        guard value.count >= 3 else {
            throw ValidationError("Hayvan ismi 3 karakterden az olamaz!" )
        }
        guard value.count < 15 else {
            throw ValidationError("Hayvan ismi 15 karakterden fazla olamaz!" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Hayvan ismi boşluk, rakam ve özel karakter içeremez.")
            }
        } catch {
            throw ValidationError("Hayvan ismi boşluk, rakam ve özel karakter içeremez.")
        }
        return value
    }
}

class LocationValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Bulunduğu yer alanı zorunludur!")}
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Bulunduğu yer bilgisi boşluk, rakam ve özel karakter içeremez.")
            }
        } catch {
            throw ValidationError("Bulunduğu yer bilgisi boşluk, rakam ve özel karakter içeremez.")
        }
        return value
    }
}

class AnimalTypeValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Tür alanı boş bırakılamaz!")}
        return value
    }
}

class AnimalGenusValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Cins alanı boş bırakılamaz!")}
        return value
    }
}
