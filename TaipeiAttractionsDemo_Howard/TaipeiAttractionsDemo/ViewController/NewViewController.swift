//
//  NewViewController.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/10.
//

import UIKit
import WebKit

class NewViewController: TAViewController {
    
    @IBOutlet weak var newsWKWebView: WKWebView!
    var newsUrlStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("VC_TABLEVIEW_SECTION_NEWS", comment: "")
        
        if let urlStr = self.newsUrlStr {
            
            self.newsWKWebView.load(URLRequest(url: URL(string: urlStr)!))
        }
    }
}
