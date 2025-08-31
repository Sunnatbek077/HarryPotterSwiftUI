//
//  HPBookAttributes.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 28/07/25.
//

import Foundation

struct HPBookAttributes: Codable, Hashable {
    let slug: String
    let author: String
    let cover: String
    let dedication: String
    let pages: Int
    let release_date: String
    let summary: String
    let title: String
    let wiki: String
}
