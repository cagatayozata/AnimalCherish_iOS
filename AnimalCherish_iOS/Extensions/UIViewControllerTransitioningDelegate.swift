//
//  UIViewControllerTransitioningDelegate.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 25.03.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

extension AnimalViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        menuSlide.isPresenting = true
        return menuSlide
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        menuSlide.isPresenting = false
        return menuSlide
    }
    
}

extension PetShopViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        menuSlide.isPresenting = true
        return menuSlide
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        menuSlide.isPresenting = false
        return menuSlide
    }
    
}

extension ShelterViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        menuSlide.isPresenting = true
        return menuSlide
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        menuSlide.isPresenting = false
        return menuSlide
    }
    
}

extension VetViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        menuSlide.isPresenting = true
        return menuSlide
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        menuSlide.isPresenting = false
        return menuSlide
    }
    
}

extension ZooViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        menuSlide.isPresenting = true
        return menuSlide
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        menuSlide.isPresenting = false
        return menuSlide
    }
    
}
