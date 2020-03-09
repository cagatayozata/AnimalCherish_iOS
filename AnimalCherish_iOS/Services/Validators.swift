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
    case vetName
    case vetEducationInfo
    case vetCity
    case vetState
    case vetClinicInfo
    case vetPhoneNumber
    case vetMailAddress
    case vetBirthDate
    case zooEstablishDate
    case zooName
    case zooAddress
    case zooDescription
    case zooPhoneNumber
    case zooMailAddress

}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .animalId: return AnimalIdValidator()
        case .animalName: return AnimalNameValidator()
        case .location: return LocationValidator()
        case .animalType: return AnimalTypeValidator()
        case .animalGenus: return AnimalGenusValidator()
        case .vetName: return VetNameValidator()
        case .vetEducationInfo: return VetEducationInfoValidator()
        case .vetCity: return VetCityValidator()
        case .vetState: return VetStateValidator()
        case .vetClinicInfo: return VetClinicInfoValidator()
        case .vetPhoneNumber: return VetPhoneNumberValidator()
        case .vetMailAddress: return VetMailAddressValidator()
        case .vetBirthDate: return VetBirthDateValidator()
        case .zooName: return ZooNameValidator()
        case .zooEstablishDate: return ZooEstablishDateValidator()
        case .zooAddress: return ZooAddressValidator()
        case .zooDescription: return ZooDescriptionValidator()
        case .zooPhoneNumber: return ZooPhoneNumberValidator()
        case .zooMailAddress: return ZooMailAddressValidator()
        }
    }
}

    //ANIMAL Validator

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

    //VET Validator

class VetNameValidator: ValidatorConvertible {
     func validated(_ value: String) throws -> String {
          guard value.count > 0 else {throw ValidationError("Veteriner ismi zorunludur!")}
          guard value.count >= 3 else {
              throw ValidationError("Veteriner ismi 3 karakterden az olamaz!" )
          }
          guard value.count < 15 else {
              throw ValidationError("Veteriner 15 karakterden fazla olamaz!" )
          }
          
          do {
              if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                  throw ValidationError("Veteriner ismi boşluk, rakam ve özel karakter içeremez.")
              }
          } catch {
              throw ValidationError("Veteriner ismi boşluk, rakam ve özel karakter içeremez.")
          }
          return value
      }
}

class VetCityValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("İl yer alanı zorunludur!")}
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("İl  bilgisi boşluk, rakam ve özel karakter içeremez.")
            }
        } catch {
            throw ValidationError("İl bilgisi boşluk, rakam ve özel karakter içeremez.")
        }
        return value
    }
}

class VetStateValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Bulunduğu yer alanı zorunludur!")}
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("İlçe bilgisi boşluk, rakam ve özel karakter içeremez.")
            }
        } catch {
            throw ValidationError("İlçe bilgisi boşluk, rakam ve özel karakter içeremez.")
        }
        return value
    }
}

class VetEducationInfoValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Eğitim bilgisi girilmesi zorunludur!")}
        return value
    }
}

class VetClinicInfoValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Klinik bilgisi girilmesi zorunludur!")}
        return value
    }
}

class VetPhoneNumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Telefon bilgisi girilmesi zorunludur!")}
        do {
            if try NSRegularExpression(pattern:
                "0[0-9]{3}.*[0-9]{3}.*[0-9]{4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Telefon belirtilen formatta olmalıdır.")
            }
        } catch {
            throw ValidationError("Telefon belirtilen formatta olmalıdır.")
        }
        return value
    }
}

class VetMailAddressValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Mail bilgisi girilmesi zorunludur!")}
        do {
            if try NSRegularExpression(pattern:
                "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Mail belirtilen formatta olmalıdır.")
            }
        } catch {
            throw ValidationError("Mail belirtilen formatta olmalıdır.")
        }
        return value
    }
}

class VetBirthDateValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Doğum tarihi bilgisi girilmesi zorunludur!")}
        return value
    }
}

    // ZOO validator

class ZooNameValidator: ValidatorConvertible {
     func validated(_ value: String) throws -> String {
          guard value.count > 0 else {throw ValidationError("Hayvanat Bahçesi ismi zorunludur!")}
          return value
      }
}

class ZooEstablishDateValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Kuruluş tarihi bilgisi girilmesi zorunludur!")}
        return value
    }
}

class ZooPhoneNumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Telefon bilgisi girilmesi zorunludur!")}
        do {
            if try NSRegularExpression(pattern:
                "0[0-9]{3}.*[0-9]{3}.*[0-9]{4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Telefon belirtilen formatta olmalıdır.")
            }
        } catch {
            throw ValidationError("Telefon belirtilen formatta olmalıdır.")
        }
        return value
    }
}


class ZooMailAddressValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Mail bilgisi girilmesi zorunludur!")}
        do {
            if try NSRegularExpression(pattern:
                "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Mail belirtilen formatta olmalıdır.")
            }
        } catch {
            throw ValidationError("Mail belirtilen formatta olmalıdır.")
        }
        return value
    }
}

class ZooDescriptionValidator: ValidatorConvertible {
     func validated(_ value: String) throws -> String {
          guard value.count > 0 else {throw ValidationError("Hayvanat Bahçesi açıklaması zorunludur!")}
          return value
      }
}

class ZooAddressValidator: ValidatorConvertible {
     func validated(_ value: String) throws -> String {
          guard value.count > 0 else {throw ValidationError("Hayvanat Bahçesi adresi zorunludur!")}
          return value
      }
}
