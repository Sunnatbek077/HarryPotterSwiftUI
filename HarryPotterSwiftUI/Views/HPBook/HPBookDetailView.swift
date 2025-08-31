//
//  HPBookDetailView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 04/08/25.
//

import SwiftUI

struct HPBookDetailView: View {
    let book: HPBook
    var body: some View {
        ScrollView {
            Text(book.attributes.title)
                .font(.largeTitle)
                .bold()
            AsyncImage(url: URL(string: "https://www.wizardingworld.com/images/products/books/UK/rectangle-1.jpg")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .padding()
                default:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
            DetailRow(title: "Title", value: book.attributes.title)
            DetailRow(title: "Author", value: book.attributes.author)
            DetailRow(title: "Release Date", value: book.attributes.release_date)
            DetailRow(title: "Pages", value: book.attributes.pages.description)
            DetailRow(title: "Dedication", value: book.attributes.dedication)
            DetailRow(title: "Summary", value: book.attributes.summary)
            
        }
    }
}


#Preview {
    HPBookDetailView(book: .mockBook)
}
