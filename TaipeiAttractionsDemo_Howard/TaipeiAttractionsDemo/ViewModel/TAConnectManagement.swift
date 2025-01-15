//
//  TAConnectManagement.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/8.
//

import UIKit
import Alamofire

class TAConnectManagement: NSObject {
    
    private let baseURL = "https://www.travel.taipei/open-api"
    
    static let shared = TAConnectManagement()
    
    func getAttractions(lang: String, page: Int32, onSuccess: @escaping([String: Any]) -> Void, onFailure: @escaping([String: String]) -> Void) -> Void {
        
        let path = "\(baseURL)/\(lang)/Attractions/All?page=\(page)"
        
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        AF.request(request).responseJSON(completionHandler: { response in
            
            if let statusCode = response.response?.statusCode {
                
                if statusCode == 200 {
                    
                    if let resultDic = response.value as? [String: Any] {
                        
                        onSuccess(resultDic)
                    }
                } else {
                    
                    let statusCodeSt = "\(statusCode)"
                    onFailure(["statusCode": statusCodeSt])
                }
            } else {
                
            }
        })
    }
    
    func getNews(lang: String, page: Int32, onSuccess: @escaping([String: Any]) -> Void, onFailure: @escaping([String: String]) -> Void) -> Void {
        
        let path = "\(baseURL)/\(lang)/Events/News?page=\(page)"
        
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        AF.request(request).responseJSON(completionHandler: { response in
            
            if let statusCode = response.response?.statusCode {
                
                if statusCode == 200 {
                    
                    if let resultDic = response.value as? [String: Any] {
                        
                        onSuccess(resultDic)
                    }
                } else {
                    
                    let statusCodeSt = "\(statusCode)"
                    onFailure(["statusCode": statusCodeSt])
                }
            } else {
                
            }
        })
    }
    
    class func getLanguageCode() -> String {
        
        var api = ""
        if let lang = Locale.current.language.languageCode?.identifier {
            
            if lang == "zh" {
                
                let identifier = Locale.current.identifier
                
                if Locale.current.identifier == "zh_TW" || identifier.hasPrefix("zh-Hant") || identifier.hasPrefix("zh-Hant_TW") {
                    
                    api = "zh-tw"
                } else if identifier == "zh-CN" || identifier.hasPrefix("zh-Hans") || identifier.hasPrefix("zh-Hans_TW") {
                    
                    api = "zh-cn"
                }
            } else {
                
                api = lang
            }
        }
        
        return api
    }
}
