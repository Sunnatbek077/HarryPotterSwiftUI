//
//  HPSpellCellView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 08/08/25.
//

import SwiftUI

struct HPSpellCellView: View {
    var imageURL: URL?
    var name: String
    var incantation: String?
    var category: String?
    
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
                        .frame(width: 120, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                        )
                case .failure:
                    defaultSpellImage
                @unknown default:
                    defaultSpellImage
                }
                
            }
            
            // MARK: - Spell Details
            VStack(alignment: .leading, spacing: 6) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                if let incantation = incantation, !incantation.isEmpty {
                    Text("Incantation:\(incantation)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                if let category = category, !category.isEmpty {
                    Text("Category: \(category)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
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
    var defaultSpellImage: some View {
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
    HPSpellCellView(
        imageURL: URL(string: "https://static.wikia.nocookie.net/harrypotter/images/2/29/Sonorous_GOF_Dumbledore_1.jpg")!,
        name: "Amplifying Charm",
        incantation: "Sonorus(soh-NOHR-us)",
        category: "Charm"
    )
}
