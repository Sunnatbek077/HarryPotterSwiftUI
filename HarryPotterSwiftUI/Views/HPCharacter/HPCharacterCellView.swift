//
//  HPCharacterCellView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 30/07/25.
//

import SwiftUI

struct HPCharacterCellView: View {
    var imageURL: URL?
    var name: String?
    var species: String?
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                // MARK: - Image from API with fallback
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: 150)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 145, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                            )
                            .clipped()
                        
                    case .failure:
                        defaultCharacterImage
                    @unknown default:
                        defaultCharacterImage
                    }
                }
                .frame(width: 140, height: 150)
                
                // MARK: - Text Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(name ?? "Unknown")
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(species ?? "Unknown species")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                .padding(.horizontal, 4)
            }
            .padding()
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        .frame(width: 180, height: 250)
    }
    
    // MARK: - Default image view
    public var defaultCharacterImage: some View {
        Image(systemName: "person.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 145, height: 150)
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    HPCharacterCellView(
        imageURL: URL(string: "https://hp-api.onrender.com/images/harry.jpg"),
        name: "Harry Potter",
        species: "Human"
    )
}
