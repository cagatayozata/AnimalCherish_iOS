//
//  FeedItemWebViewController.swift
//  AnimalCherish_iOS
//
//  Created by Metehan kara on 14.04.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import UIKit
import WebKit

class FeedItemWebViewController: UIViewController {
   
    
    @IBOutlet weak var webView: WKWebView!
    var selectedFeedURL: String?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: " ", with:"")
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: "\n", with:"")
        webView.load(URLRequest(url: URL(string: selectedFeedURL! as String)!))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
    }
}
