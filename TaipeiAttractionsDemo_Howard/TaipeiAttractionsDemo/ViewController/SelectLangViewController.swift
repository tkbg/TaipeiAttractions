//
//  SelectLangViewController.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/10.
//

import UIKit

class SelectLangViewController: TAViewController {
    
    @IBOutlet weak var langView: UIView!
    
    @IBOutlet weak var zhTwButton: UIButton!
    @IBOutlet weak var zhCnButton: UIButton!
    @IBOutlet weak var enButton: UIButton!
    @IBOutlet weak var jaButton: UIButton!
    @IBOutlet weak var koButton: UIButton!
    @IBOutlet weak var esButton: UIButton!
    @IBOutlet weak var idButton: UIButton!
    @IBOutlet weak var thButton: UIButton!
    @IBOutlet weak var viButton: UIButton!
    
    @IBOutlet weak var zhTwLabel: UILabel!
    @IBOutlet weak var zhCnLabel: UILabel!
    @IBOutlet weak var enLabel: UILabel!
    @IBOutlet weak var jaLabel: UILabel!
    @IBOutlet weak var koLabel: UILabel!
    @IBOutlet weak var esLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var thLabel: UILabel!
    @IBOutlet weak var viLabel: UILabel!
    
    @IBOutlet weak var zhTwBgView: UIView!
    @IBOutlet weak var zhCnBgView: UIView!
    @IBOutlet weak var enBgView: UIView!
    @IBOutlet weak var jaBgView: UIView!
    @IBOutlet weak var koBgView: UIView!
    @IBOutlet weak var esBgView: UIView!
    @IBOutlet weak var idBgView: UIView!
    @IBOutlet weak var thBgView: UIView!
    @IBOutlet weak var viBgView: UIView!
    
    /*
     繁體中文
     简体中文
     English
     日本語
     한국어
     Español
     Bahasa Indonesia
     ไทย-ไทย
     Tiếng Việt
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resetView()
        
        if let appLangs = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String], let lage = appLangs.first {
            
            switch lage {
            case "zh-Hant":
                self.zhTwLabel.textColor = UIColor(named: "LangTextSelectedColor")
                self.zhTwBgView.backgroundColor = UIColor(named: "BGColor")
            case "zh-Hans":
                self.zhCnLabel.textColor = UIColor(named: "LangTextSelectedColor")
                self.zhCnBgView.backgroundColor = UIColor(named: "BGColor")
            case "en":
                self.enLabel.textColor = UIColor(named: "LangTextSelectedColor")
                self.enBgView.backgroundColor = UIColor(named: "BGColor")
            case "ja":
                self.jaLabel.textColor = UIColor(named: "LangTextSelectedColor")
                self.jaBgView.backgroundColor = UIColor(named: "BGColor")
            case "ko":
                self.koLabel.textColor = UIColor(named: "LangTextSelectedColor")
                self.koBgView.backgroundColor = UIColor(named: "BGColor")
            case "es":
                self.esLabel.textColor = UIColor(named: "LangTextSelectedColor")
                self.esBgView.backgroundColor = UIColor(named: "BGColor")
            case "id":
                self.idLabel.textColor = UIColor(named: "LangTextSelectedColor")
                self.idBgView.backgroundColor = UIColor(named: "BGColor")
            case "th":
                self.thLabel.textColor = UIColor(named: "LangTextSelectedColor")
                self.thBgView.backgroundColor = UIColor(named: "BGColor")
            case "vi":
                self.viLabel.textColor = UIColor(named: "LangTextSelectedColor")
                self.viBgView.backgroundColor = UIColor(named: "BGColor")
            default:
                self.resetView()
            }
        }
    }
    
    func resetView() -> Void {
        
        self.zhTwLabel.textColor = UIColor(named: "LangTextColor")
        self.zhCnLabel.textColor = UIColor(named: "LangTextColor")
        self.enLabel.textColor = UIColor(named: "LangTextColor")
        self.jaLabel.textColor = UIColor(named: "LangTextColor")
        self.koLabel.textColor = UIColor(named: "LangTextColor")
        self.esLabel.textColor = UIColor(named: "LangTextColor")
        self.idLabel.textColor = UIColor(named: "LangTextColor")
        self.thLabel.textColor = UIColor(named: "LangTextColor")
        self.viLabel.textColor = UIColor(named: "LangTextColor")
        
        self.zhTwBgView.backgroundColor = UIColor.clear
        self.zhCnBgView.backgroundColor = UIColor.clear
        self.enBgView.backgroundColor = UIColor.clear
        self.jaBgView.backgroundColor = UIColor.clear
        self.koBgView.backgroundColor = UIColor.clear
        self.esBgView.backgroundColor = UIColor.clear
        self.idBgView.backgroundColor = UIColor.clear
        self.thBgView.backgroundColor = UIColor.clear
        self.viBgView.backgroundColor = UIColor.clear
    }
    
    func selectedLang(langCode: String, apiLang: String) -> Void {
        
        UserDefaults.standard.set(apiLang, forKey: "api.Lang")
        UserDefaults.standard.synchronize()
        
        Bundle.setLanguage(langCode)
        
        if let window = UIApplication.shared.windows.first {
            
            window.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            window.makeKeyAndVisible()
        }
    }
    
    @IBAction func langBtnPressed(_ sender: UIButton) {
        
        self.resetView()
        
        var langCode = ""
        var apiLang = ""
        switch sender.tag {
        case 0:
            langCode = "zh-Hant"
            apiLang = "zh-tw"
            self.zhTwLabel.textColor = UIColor(named: "LangTextSelectedColor")
            self.zhTwBgView.backgroundColor = UIColor.systemBlue
        case 1:
            langCode = "zh-Hans"
            apiLang = "zh-cn"
            self.zhCnLabel.textColor = UIColor(named: "LangTextSelectedColor")
            self.zhCnBgView.backgroundColor = UIColor.systemBlue
        case 2:
            langCode = "en"
            apiLang = "en"
            self.enLabel.textColor = UIColor(named: "LangTextSelectedColor")
            self.enBgView.backgroundColor = UIColor.systemBlue
        case 3:
            langCode = "ja"
            apiLang = "ja"
            self.jaLabel.textColor = UIColor(named: "LangTextSelectedColor")
            self.jaBgView.backgroundColor = UIColor.systemBlue
        case 4:
            langCode = "ko"
            apiLang = "ko"
            self.koLabel.textColor = UIColor(named: "LangTextSelectedColor")
            self.koBgView.backgroundColor = UIColor.systemBlue
        case 5:
            langCode = "es"
            apiLang = "es"
            self.esLabel.textColor = UIColor(named: "LangTextSelectedColor")
            self.esBgView.backgroundColor = UIColor.systemBlue
        case 6:
            langCode = "id"
            apiLang = "en" // API 不支援 id 語言
            self.idLabel.textColor = UIColor(named: "LangTextSelectedColor")
            self.idBgView.backgroundColor = UIColor.systemBlue
        case 7:
            langCode = "th"
            apiLang = "th"
            self.thLabel.textColor = UIColor(named: "LangTextSelectedColor")
            self.thBgView.backgroundColor = UIColor.systemBlue
        case 8:
            langCode = "vi"
            apiLang = "vi"
            self.viLabel.textColor = UIColor(named: "LangTextSelectedColor")
            self.viBgView.backgroundColor = UIColor.systemBlue
        default:
            self.resetView()
        }
        
        self.selectedLang(langCode: langCode, apiLang: apiLang)
    }
}
