//
//  HPGetAllPPotionsResponse.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 07/08/25.
//

import Foundation

struct HPGetAllPotionsResponse: Codable {
    struct HPGetAllPotionsMeta: Codable {
        struct HPPotionPagination: Codable {
            let current: Int
            let next: Int?
            let last: Int?
            let records: Int
        }
        
        let pagination: HPPotionPagination
        let copyright: String
        let generated_at: String
        
    }
    
    struct HPGetAllPotionsLinks: Codable {
        let `self`: String
        let current: String
        let next: String?
        let last: String?
    }
    
    let data: [HPPotion]
    let meta: HPGetAllPotionsMeta
    let links: HPGetAllPotionsLinks
}
