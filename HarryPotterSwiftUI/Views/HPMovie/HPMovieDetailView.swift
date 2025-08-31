//
//  HPMovieDetailView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 06/08/25.
//

import SwiftUI

struct HPMovieDetailView: View {
    let movie: HPMovie
    var body: some View {
        ScrollView {
            Text(movie.attributes.title)
                .font(.largeTitle)
                .bold()
            AsyncImage(url: URL(string: "https://www.wizardingworld.com/images/products/films/rectangle-1.png")) { phase in
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
            
            DetailRow(title: "Title", value: movie.attributes.title)
            DetailRow(title: "Release Date", value: movie.attributes.release_date)
            DetailRow(title: "Box Office", value: movie.attributes.box_office)
            DetailRow(title: "Budget", value: movie.attributes.budget)
            DetailRow(title: "Rating", value: movie.attributes.rating)
            DetailRow(title: "Summary", value: movie.attributes.summary)
            
            DetailArrayRow(title: "Cinematographers", values: movie.attributes.cinematographers)
            DetailArrayRow(title: "Directors", values: movie.attributes.directors)
            DetailArrayRow(title: "Editors", values: movie.attributes.editors)
            DetailArrayRow(title: "Music Composers", values: movie.attributes.music_composers)
            DetailArrayRow(title: "Producers", values: movie.attributes.producers)
            DetailArrayRow(title: "Screen Writers", values: movie.attributes.screenwriters)
        }
    }
}

#Preview {
    HPMovieDetailView(movie: .mockMovie)
}
