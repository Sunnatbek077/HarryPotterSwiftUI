//
//  HPSpellDetailView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 08/08/25.
//

import SwiftUI

struct HPSpellDetailView: View {
    let spell: HPSpell
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text(spell.attributes.name)
                .font(.largeTitle)
            AsyncImage(url: URL(string: spell.attributes.image ?? "flask.fill")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .padding()
                default:
                    Image(systemName: "lightbulb")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(maxHeight: 400)
                
                }
            }
            DetailRow(title: "Name", value: spell.attributes.name)
            DetailRow(title: "Effect", value: spell.attributes.effect)
            DetailRow(title: "Category", value: spell.attributes.category)
            DetailRow(title: "Light", value: spell.attributes.light ?? "Unknown")
            DetailRow(title: "Hand", value: spell.attributes.hand ?? "Unknown")
            DetailRow(title: "Incantation", value: spell.attributes.incantation ?? "Unknown")
            DetailRow(title: "Creator", value: spell.attributes.creator ?? "Unknown")
            if let url = URL(string: spell.attributes.wiki), !spell.attributes.wiki.isEmpty {
                Button(action: {
                    openURL(url)
                }) {
                    DetailRow(title: "Wiki", value: spell.attributes.wiki)
                        .foregroundColor(.blue)
                }
            } else {
                DetailRow(title: "Wiki", value: "Unknown")
            }
        }
    }
}

#Preview {
    HPSpellDetailView(spell: .mockSpell)
}
