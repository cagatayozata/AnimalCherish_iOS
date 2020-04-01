//
//  Alert.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 1.04.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//


import Foundation
import UIKit

public class Alert {
    
    class func showAlert(message:String, vc:UIViewController) {
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true, completion: nil)
        
    }
    
    class func showAlertThenPreviousScreen(message:String, vc:UIViewController) {
    
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: { (action: UIAlertAction!) in
            vc.navigationController?.popViewController(animated: true)
        })
        
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true, completion: nil)
    
    }
    
}
