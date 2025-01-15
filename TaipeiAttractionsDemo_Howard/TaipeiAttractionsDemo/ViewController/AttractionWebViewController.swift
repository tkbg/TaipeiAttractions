//
//  NewViewController.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/10.
//

import UIKit
import WebKit

class AttractionWebViewController: TAViewController {
    
    @IBOutlet weak var attWKWebView: WKWebView!
    
    var attTitleStr: String?
    var attUrlStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let attTitle = self.attTitleStr {
            
            self.title = attTitle
        }
        
        if let urlStr = self.attUrlStr {
            
            self.attWKWebView.load(URLRequest(url: URL(string: urlStr)!))
        }
    }
}
