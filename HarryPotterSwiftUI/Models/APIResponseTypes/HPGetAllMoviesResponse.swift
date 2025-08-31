//
//  HPGetAllMoviesResponse.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 06/08/25.
//

import Foundation

struct HPGetAllMoviesResponse: Codable {
    struct HPGetAllMoviesMeta: Codable {
        struct HPMoviePagination: Codable {
            let current: Int
            let records: Int
        }
        
        let pagination: HPMoviePagination
        let copyright: String
        let generated_at: String
        
    }
    
    struct HPGetAllMoviesLinks: Codable {
        let `self`: String
        let current: String
    }
    
    let data: [HPMovie]
    let meta: HPGetAllMoviesMeta
    let links: HPGetAllMoviesLinks
}
