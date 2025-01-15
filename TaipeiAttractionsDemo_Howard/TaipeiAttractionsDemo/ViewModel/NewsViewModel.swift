//
//  EventsViewModel.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/8.
//

import Foundation
import Alamofire

class NewsViewModel {
    
    var page: Int32 = 0
    var totalPages: Int32 = 0
    var total: Int = -1
    var news: [News] = []
    
    func fetchNewsList(lang: String, page: Int32) -> Void {
        
        self.fetchNewsList(lang: lang, page: page, post: false)
    }
    
    func fetchNewsList(lang: String, page: Int32, post: Bool = false) -> Void {
        
        TAConnectManagement.shared.getNews(lang: lang, page: page) { resultDic in
            
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
            
            if let eventArray = resultDic["data"] as? [[String: Any]] {
                
                for event in eventArray {
                    
                    do {
                        let jsonData = try? JSONSerialization.data(withJSONObject: event)
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let event = try decoder.decode(News.self, from: jsonData!)
//                        print("解碼成功: \(event)")
                        
                        self.news.append(event)
                    } catch {
                        
//                        print("解碼失敗: \(error)")
                    }
                }
            }
            
            if post == true {
                
                NotificationCenter.default.post(name: Notification.Name("ReloadTable.News"), object: nil)
            }
        } onFailure: { errorDic in
            
            self.total = 0
            
            if post == true {
                
                NotificationCenter.default.post(name: Notification.Name("ReloadTable.News"), object: nil)
            }
        }
    }
}
