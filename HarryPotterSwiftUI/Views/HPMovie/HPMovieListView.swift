//
//  HPMovieListView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 06/08/25.
//

import SwiftUI

struct HPMovieListView: View {
    @ObservedObject var viewModel: HPMovieListViewModel
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading && viewModel.movies.isEmpty {
                VStack {
                    Spacer()
                    ProgressView("Loading movies...")
                        .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 600)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if viewModel.movies.isEmpty {
                Text("No movies found.")
                    .foregroundStyle(.secondary)
                    .padding()
            } else {
                ForEach(viewModel.movies) { movie in
                    NavigationLink {
                        HPMovieDetailView(movie: movie)
                    } label: {
                        HPMovieCellView(
                            imagePosterURL: viewModel.makeImageURL(from: movie.attributes.poster),
                            title: movie.attributes.title,
                            release_date: movie.attributes.release_date,
                            rating: movie.attributes.rating,
                            running_time: movie.attributes.running_time
                        )
                    }
                    
                }
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
        }
        .navigationTitle("Movies")
        .refreshable {
            await viewModel.fetchMovies()
        }
        .task {
            if viewModel.movies.isEmpty {
                await viewModel.fetchMovies()
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search movies")
    }
}

#Preview {
    HPMovieListView(viewModel: .init())
}
