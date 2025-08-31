//
//  HPSpell.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 28/07/25.
//

import Foundation

struct HPSpell: Codable, Identifiable {
    let id: String
    let type: String
    let attributes: HPSpellAttributes
    let links: HPSpellLinks
}

