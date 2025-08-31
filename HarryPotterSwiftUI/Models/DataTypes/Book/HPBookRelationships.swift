//
//  HPBookRelationships.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 28/07/25.
//

import Foundation

struct HPBookRelationships: Codable, Hashable {
    let chapters: HPBookRelationshipChapters?
}

struct HPBookRelationshipChapters: Codable, Hashable {
    let data: [HPBookRelationshipChaptersData]
}

struct HPBookRelationshipChaptersData: Codable, Hashable {
    let type: String
    let id: String
}
