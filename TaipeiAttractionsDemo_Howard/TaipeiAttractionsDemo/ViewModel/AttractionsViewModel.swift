//
//  AttractionsViewModel.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/8.
//

import Foundation
import Alamofire

class AttractionsViewModel {
    
    var page: Int32 = 0
    var totalPages: Int32 = 0
    var total: Int = -1
    var attractions: [Attraction] = []
    
    func fetchAttractionsList(lang: String, page: Int32) -> Void {
        
        self.fetchAttractionsList(lang: lang, page: page, post: false)
    }
    
    func fetchAttractionsList(lang: String, page: Int32, post: Bool = false) -> Void {
        
        TAConnectManagement.shared.getAttractions(lang: lang, page: page) { resultDic in
            
            if let total = resultDic["total"] as? Int {
                
                self.total = total
                
                let calculate = self.total.quotientAndRemainder(dividingBy: 30)
                if calculate.remainder > 0 {
                    
                    self.totalPages = Int32(calculate.quotient + 1)
                } else {
                    
                    self.totalPages = Int32(calculate.quotient)
                }
            }
            
            if self.total > 0 {
                
                self.page = page
            }
            
            if let attractionArray = resultDic["data"] as? [[String: Any]] {
                
                for attraction in attractionArray {
                    
                    do {
                        let jsonData = try? JSONSerialization.data(withJSONObject: attraction)
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let attraction = try decoder.decode(Attraction.self, from: jsonData!)
//                        print("解碼成功: \(attraction)")
                        
                        self.attractions.append(attraction)
                    } catch {
                        
//                        print("解碼失敗: \(error)")
                    }
                }
            }
            
            if post == true {
                
                NotificationCenter.default.post(name: Notification.Name("ReloadTable.Attractions"), object: nil)
            }
        } onFailure: { errorDic in
            
            self.total = 0
            
            if post == true {
                
                NotificationCenter.default.post(name: Notification.Name("ReloadTable.Attractions"), object: nil)
            }
        }
    }
}
