//
//  File.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 28/07/25.
//

import Foundation

enum HPEndpoint: String, CaseIterable, Hashable {
    /// Endpoint to get book info
    case books
    /// Endpoint to get character info
    case characters
    /// Endpoint to get movie info
    case movies
    /// Endpoint to get potion info
    case potions
    /// Endpoint to get spell info
    case spells
}
