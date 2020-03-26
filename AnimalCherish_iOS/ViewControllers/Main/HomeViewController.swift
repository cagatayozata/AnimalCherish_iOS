//
//  HomeViewController.swift
//  AnimalCherish_iOS
//
//  Created by Cagatay Ozata on 26.02.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // Reachability
    let reachability = try! Reachability()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Internet connection check
        checkInternetConnection()
        
    }
    
    func createAlert() {
        
        let alert = UIAlertController.init(title: "İnternet Bağlantısı", message: "Uygulamanın kullanılabilmesi için aktif internet bağlantısı gerekmektedir. Lütfen cihazınızı internete bağlayınız.", preferredStyle: .alert)
        
        let retryAction = UIAlertAction.init(title: "Tamam", style: .default) { _ in
            print("Internet connection alert..")
        }
        
        alert.addAction(retryAction)
        self.present(alert, animated: true, completion: nil)
    
    }
    
    func checkInternetConnection() {
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.createAlert()
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
