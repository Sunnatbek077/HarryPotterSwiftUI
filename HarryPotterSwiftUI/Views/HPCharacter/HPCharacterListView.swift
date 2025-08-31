//
//  HPCharacterListView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 30/07/25.
//

import SwiftUI

struct HPCharacterListView: View {
    @ObservedObject var viewModel: HPCharacterListViewModel
    
    
    private let gridLayout = [
        GridItem(.adaptive(minimum: 160), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            // Characters tab ichida:
            if viewModel.isLoading && viewModel.characters.isEmpty {
                VStack {
                    Spacer()
                    ProgressView("Loading characters...")
                        .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 600)
                
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding()
                
            } else if viewModel.characters.isEmpty {
                Text("No characters found.")
                    .foregroundStyle(.secondary)
                    .padding()
                
            } else {
                LazyVGrid(columns: gridLayout, spacing: 16) {
                    ForEach(viewModel.characters) { character in
                        NavigationLink {
                            HPCharacterDetailView(character: character)
                        } label: {
                            HPCharacterCellView(
                                imageURL: viewModel.makeImageURL(from: character.attributes.image),
                                name: character.attributes.name,
                                species: character.attributes.species
                            )
                        }
                        .onAppear {
                            if character.id == viewModel.characters.last?.id && viewModel.searchText.isEmpty {
                                Task {
                                    await viewModel.loadMoreCharacters()
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)

                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
        }
        .navigationTitle("Characters")
        .refreshable {
            await viewModel.fetchCharacters()
        }
        .task {
            if viewModel.characters.isEmpty {
                await viewModel.fetchCharacters()
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search characters")
    }
}

#Preview {
    HPCharacterListView(viewModel: .init())
}
