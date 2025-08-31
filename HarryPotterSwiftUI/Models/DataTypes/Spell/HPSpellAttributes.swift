//
//  HPSpellAttributes.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 28/07/25.
//

import Foundation

struct HPSpellAttributes: Codable {
    let slug: String
    let category: String
    let creator: String?
    let effect: String
    let hand: String?
    let image: String?
    let incantation: String?
    let light: String?
    let name: String
    let wiki: String
}
