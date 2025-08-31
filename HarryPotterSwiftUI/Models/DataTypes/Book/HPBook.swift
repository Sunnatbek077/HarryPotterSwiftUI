//
//  HPBook.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 28/07/25.
//

import Foundation

struct HPBook: Codable, Identifiable, Hashable {
    let id: String
    let type: String
    let attributes: HPBookAttributes
    let relationships: HPBookRelationships
    let links: HPBookLinks
}
