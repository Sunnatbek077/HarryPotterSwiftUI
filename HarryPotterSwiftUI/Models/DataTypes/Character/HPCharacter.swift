//
//  HPCharacter.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 28/07/25.
//

import Foundation

struct HPCharacter: Codable, Identifiable, Hashable {
    let id: String
    let type: String
    let attributes: HPCharacterAttributes
    let links: HPCharacterLinks
    
    // Hashable - faqat id asosida
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // Identifiable bo'lishi uchun `id` unikalligi muhim
    static func == (lhs: HPCharacter, rhs: HPCharacter) -> Bool {
        lhs.id == rhs.id
    }
}

struct HPCharacterLinks: Codable, Hashable {
    let `self`: String
}
