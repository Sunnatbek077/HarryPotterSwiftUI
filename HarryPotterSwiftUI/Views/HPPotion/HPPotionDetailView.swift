//
//  HPPotionDetailView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 07/08/25.
//

import SwiftUI

struct HPPotionDetailView: View {
    let potion: HPPotion
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            AsyncImage(url: URL(string: potion.attributes.image ?? "flask.fill")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .padding()
                default:
                    Image(systemName: "flask.fill")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(maxHeight: 400)
                }
            }
            
            DetailRow(title: "Name", value: potion.attributes.name)
            DetailRow(title: "Difficulty", value: potion.attributes.difficulty ?? "Unknown")
            DetailRow(title: "Effect", value: potion.attributes.effect ?? "Unknown")
            DetailRow(title: "Characteristic", value: potion.attributes.characteristics ?? "Unknown")
            
        }
    }
}

#Preview {
    HPPotionDetailView(potion: .mockPotion)
}
