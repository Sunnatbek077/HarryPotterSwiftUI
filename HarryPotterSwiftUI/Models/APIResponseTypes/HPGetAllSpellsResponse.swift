//
//  HPGetAllSpellsResponse.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 08/08/25.
//

import Foundation

struct HPGetAllSpellsResponse: Codable {
    struct HPGetAllSpellsMeta: Codable {
        struct HPSpellPagination: Codable {
            let current: Int
            let next: Int
            let last: Int
            let records: Int
        }
        
        let pagination: HPSpellPagination
        let copyright: String
        let generated_at: String
    }
    
    struct HPGetAllSpellsLinks: Codable {
        let `self`: String
        let current: String
        let next: String
        let last: String
    }
    
    let data: [HPSpell]
    let meta: HPGetAllSpellsMeta
    let links: HPGetAllSpellsLinks
    
}
