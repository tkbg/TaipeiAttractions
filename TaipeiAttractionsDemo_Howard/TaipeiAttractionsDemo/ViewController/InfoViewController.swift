//
//  InfoViewController.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/10.
//

import UIKit
import WebKit

class InfoViewController: TAViewController {
    
    @IBOutlet weak var infoWKWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("VC_NAVIGATION_INFO_TITLE", comment: "")
        
        self.infoWKWebView.load(URLRequest(url: URL(string: "https://www.travel.taipei/open-api/swagger/ui/index#/")!))
    }
}
