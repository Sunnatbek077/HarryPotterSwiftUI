//
//  HPGetAllCharactersResponse.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 31/07/25.
//

import Foundation

struct HPGetAllCharactersResponse: Codable {
    struct HPGetAllCharactersMeta: Codable {
        struct HPCharacterPagination: Codable {
            let current: Int
            let next: Int
            let last: Int
            let records: Int
        }
        
        let pagination: HPCharacterPagination
        let copyright: String
        let generated_at: String
        
    }
    
    struct HPGetAllCharactersLinks: Codable {
        let `self`: String
        let current: String
        let next: String
        let last: String
    }
    
    let data: [HPCharacter]
    let meta: HPGetAllCharactersMeta
    let links: HPGetAllCharactersLinks
}
