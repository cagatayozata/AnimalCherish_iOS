//
//  UIView.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 15.04.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

var loadingIndicator : UIView?
 
extension UIViewController {
    
    func showLoadingIndicator(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        loadingIndicator = spinnerView
    }
    
    func removeLoadingIndicator() {
        DispatchQueue.main.async {
            loadingIndicator?.removeFromSuperview()
            loadingIndicator = nil
        }
    }
    
}
