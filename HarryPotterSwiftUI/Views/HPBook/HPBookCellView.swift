//
//  HPBookCellView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 04/08/25.
//

import SwiftUI

struct HPBookCellView: View {
    var imageURL: URL?
    var name: String
    var release_date: String
    var pagesCount: Int
    var authorName: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            
            // MARK: - Book Image
            AsyncImage(url: imageURL) { phase in
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
                Text(name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text("📅 \(release_date)")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
                Text("📖 \(pagesCount) pages")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
                Text("✍️ \(authorName)")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
                Spacer() // faqat textni yuqorida ushlab turish uchun emas, pastda bo‘sh joy qoldirish uchun
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
    HPBookCellView(
        imageURL: URL(string: "https://www.wizardingworld.com/images/products/books/UK/rectangle-1.jpg"),
        name: "Harry Potter and the Philosopher's Stone",
        release_date: "1997-06-26",
        pagesCount: 223,
        authorName: "J.K. Rowling"
    )
}
