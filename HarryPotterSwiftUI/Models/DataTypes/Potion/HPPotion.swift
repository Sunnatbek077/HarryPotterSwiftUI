//
//  HPPotion.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 28/07/25.
//

import Foundation

struct HPPotion: Codable, Identifiable {
    let id: String
    let type: String
    let attributes: HPPotionAttributes
    let links: HPPotionLinks
}
