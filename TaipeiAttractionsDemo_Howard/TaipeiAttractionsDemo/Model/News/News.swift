//
//  News.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/7.
//

import Foundation

struct News: Decodable {
    
    let id: Int
    let title: String
    let description: String
    let begin: String?
    let end: String?
    let posted: String
    let modified: String
    let url: String
    let files: [NewsFile]
    let links: [NewsLink]
    
    enum CodingKeys: String, CodingKey {
            case id, title, description, begin, end, posted, modified, url, files, links
        }
}
