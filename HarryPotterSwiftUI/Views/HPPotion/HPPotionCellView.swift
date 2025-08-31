//
//  HPPotionCellView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 07/08/25.
//

import SwiftUI

struct HPPotionCellView: View {
    var imageURL: URL?
    var name: String
    var difficulty: String?
    var effectName: String?
    var characteristics: String?

    var body: some View {
        HStack(spacing: 16) {
            // MARK: - Image from URL or default
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.ultraThinMaterial)
                            .frame(width: 120, height: 150)
                        ProgressView()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                        )
                case .failure:
                    defaultPotionImage
                @unknown default:
                    defaultPotionImage
                }
            }

            // MARK: - Potion Details
            VStack(alignment: .leading, spacing: 6) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                if let difficulty = difficulty, !difficulty.isEmpty {
                    Text("Difficulty: \(difficulty)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }

                if let effect = effectName, !effect.isEmpty {
                    Text("Effect: \(effect)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }

                if let traits = characteristics, !traits.isEmpty {
                    Text("Traits: \(traits)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 2)
    }

    // MARK: - Fallback Image
    var defaultPotionImage: some View {
        Image(systemName: "flask.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 150)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    HPPotionCellView(
        imageURL: URL(string: "https://static.wikia.nocookie.net/harrypotter/images/8/8b/Beautification_Potion_Bottle.png"),
        name: "Beautification Potion",
        difficulty: "Moderate",
        effectName: "Enhances the attractiveness of the drinker's physical appearance",
        characteristics: "Changes colour, Emits multi-colour bubbles"
    )
}
