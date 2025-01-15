//
//  TAViewController.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/10.
//

import UIKit
import ProgressHUD

class TAViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func back() {
        
        if self.navigationController != nil {
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showHud() -> Void {
        
        ProgressHUD.animate("Loading ...")
    }
    
    func hideHud() -> Void {
        
        ProgressHUD.dismiss()
    }
    
    func getLang() -> String {
        
        var lang = ""
        if let apiLang = UserDefaults.standard.object(forKey: "api.Lang") as? String {
            
            lang = apiLang
        } else {
            
            lang = TAConnectManagement.getLanguageCode()
        }
        
        return lang
    }
}
