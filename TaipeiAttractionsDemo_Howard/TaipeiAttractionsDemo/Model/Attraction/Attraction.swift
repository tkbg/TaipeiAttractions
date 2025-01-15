//
//  Attraction.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/7.
//

import Foundation

struct Attraction: Decodable {
    
    let id: Int
    let name: String
    let name_zh: String?
    let open_status: Int?
    let introduction: String?
    let open_time: String?
    let zipcode: String
    let distric: String
    let address: String?
    let tel: String?
    let fax: String
    let email: String
    let months: String
    let nlat: Double
    let elong: Double
    let official_site: String?
    let facebook: String
    let ticket: String
    let remind: String
    let staytime: String
    let modified: String
    let url: String?
    let category: [AttCategory]
    let target: [AttTarget]
    let service: [AttService]
    let friendly: [AttFriendly]?
    let images: [AttImage]
    let files: [AttFile]
    let links: [AttLink]
    
    enum CodingKeys: String, CodingKey {
            case id, name, name_zh, open_status, introduction, open_time, zipcode, distric, address, tel, fax, email, months, nlat, elong, official_site, facebook, ticket, remind, staytime, modified, url, category, target, service, friendly, images, files, links
        }
}
