//
//  HPSpellListView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 08/08/25.
//

import SwiftUI

struct HPSpellListView: View {
    @ObservedObject var viewModel: HPSpellListViewModel
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading && viewModel.spells.isEmpty {
                VStack {
                    Spacer()
                    ProgressView("Loading spells...")
                        .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 600)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if viewModel.spells.isEmpty {
                Text("No spells found.")
                    .foregroundStyle(.secondary)
                    .padding()
            } else {
                ForEach(viewModel.spells) { spell in
                    NavigationLink {
                        HPSpellDetailView(spell: spell)
                    } label: {
                        HPSpellCellView(
                            imageURL: URL(string: spell.attributes.image ?? ""),
                            name: spell.attributes.name,
                            incantation: spell.attributes.incantation,
                            category: spell.attributes.category
                        )
                    }
                }
                .padding(.horizontal)
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
        }
        .navigationTitle("Spells")
        .refreshable {
            await viewModel.fetchSpells()
        }
        .task {
            if viewModel.spells.isEmpty {
                await viewModel.fetchSpells()
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search spells")
    }
}

#Preview {
    HPSpellListView(viewModel: .init())
}
