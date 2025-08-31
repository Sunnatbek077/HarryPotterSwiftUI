//
//  ContentView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 28/07/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var characterViewModel = HPCharacterListViewModel()
    @StateObject private var bookViewModel = HPBookListViewModel()
    @StateObject private var movieViewModel = HPMovieListViewModel()
    @StateObject private var potionViewModel = HPPotionListViewModel()
    @StateObject private var spellViewModel = HPSpellListViewModel()
    
    var body: some View {
        if #available(iOS 16.0, *) {
            tabView()
                .task {
                    if characterViewModel.characters.isEmpty {
                        await characterViewModel.fetchCharacters()
                    }
                    if bookViewModel.books.isEmpty {
                        await bookViewModel.fetchBooks()
                    }
                    if movieViewModel.movies.isEmpty {
                        await movieViewModel.fetchMovies()
                    }
                    if potionViewModel.potions.isEmpty {
                        await potionViewModel.fetchPotions()
                    }
                    if spellViewModel.spells.isEmpty {
                        await spellViewModel.fetchSpells()
                    }
                }
                .tint(Color.accent)
        }
    }
    
    @ViewBuilder
    func tabView() -> some View {
        TabView {
            Tab("Characters", systemImage: "person") {
                NavigationStack {
                    HPCharacterListView(viewModel: characterViewModel)
                }
            }
            Tab("Books", systemImage: "book") {
                NavigationStack {
                    HPBookListView(viewModel: bookViewModel)
                }
            }
            Tab("Movies", systemImage: "movieclapper") {
                NavigationStack {
                    HPMovieListView(viewModel: movieViewModel)
                }
            }
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                NavigationStack {
                    SearchView()
                }
            }
            Tab("Potions", systemImage: "drop") {
                NavigationStack {
                    HPPotionListView(viewModel: potionViewModel)
                }
            }
            Tab("Spells", systemImage: "lightbulb") {
                NavigationStack {
                    HPSpellListView(viewModel: spellViewModel)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
