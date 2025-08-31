//
//  HPGetAllBooksResponse.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 04/08/25.
//

import Foundation

struct HPGetAllBooksResponse: Codable {
    struct HPGetAllBooksMeta: Codable {
            struct HPBookPagination: Codable {
                let current: Int
                let records: Int
            }
            
            let pagination: HPBookPagination
            let copyright: String
            let generated_at: String
            
        }
        
        struct HPGetAllBooksLinks: Codable {
            let `self`: String
            let current: String
        }
        
        let data: [HPBook]
        let meta: HPGetAllBooksMeta
        let links: HPGetAllBooksLinks
    
}
