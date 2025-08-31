//
//  HPMovie.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 28/07/25.
//

import Foundation

struct HPMovie: Codable, Identifiable {
    let id: String
    let type: String
    let attributes: HPMovieAttributes
    let links: HPMovieLinks
}
