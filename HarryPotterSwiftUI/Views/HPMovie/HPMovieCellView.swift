//
//  HPMovieCellView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 06/08/25.
//

import SwiftUI

struct HPMovieCellView: View {
    var imagePosterURL: URL?
    var title: String
    var release_date: String
    var rating: String
    var running_time: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // MARK: - Movie Poster
            AsyncImage(url: imagePosterURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 140, height: 210)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 210)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .clipped()
                case .failure:
                    defaultBookImage
                    @unknown default:
                    defaultBookImage
                }
                
                
                
            }
            
            // MARK: - Text Info
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                Text("📅 \(release_date)")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                Text("Rating: \(rating)")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                Text("Running Time: \(running_time)")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top) // matnni yuqoriga yopishtiradi
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 250, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
        )
        .padding(.horizontal)
    }
    
    public var defaultBookImage: some View {
        Image(systemName: "book.closed.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 140, height: 210)
            .foregroundColor(.gray.opacity(0.5))
            .padding()
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    HPMovieCellView(
        imagePosterURL: URL(string: "https://www.wizardingworld.com/images/products/films/rectangle-1.png"),
        title: "Harry Potter and the Philosopher's Stone",
        release_date: "2001-11-04",
        rating: "PG",
        running_time: "152 minutes"
    )
}
