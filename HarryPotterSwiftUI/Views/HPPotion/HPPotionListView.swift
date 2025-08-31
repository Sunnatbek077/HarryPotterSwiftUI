//
//  HPPotionListView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 07/08/25.
//

import SwiftUI

struct HPPotionListView: View {
    @ObservedObject var viewModel: HPPotionListViewModel
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading && viewModel.potions.isEmpty {
                VStack {
                    Spacer()
                    ProgressView("Loading potions...")
                        .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 600)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if viewModel.potions.isEmpty {
                Text("No potions found.")
                    .foregroundStyle(.secondary)
                    .padding()
            } else {
                ForEach(viewModel.potions) { potion in
                    NavigationLink {
                        HPPotionDetailView(potion: potion)
                    } label: {
                        HPPotionCellView(
                            imageURL: URL(string: potion.attributes.image ?? ""),
                            name: potion.attributes.name,
                            difficulty: potion.attributes.difficulty,
                            effectName: potion.attributes.effect,
                            characteristics: potion.attributes.characteristics
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
        .navigationTitle("Potions")
        .refreshable {
            await viewModel.fetchPotions()
        }
        .task {
            if viewModel.potions.isEmpty {
                await viewModel.fetchPotions()
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search potions")
    }
}

#Preview {
    HPPotionListView(viewModel: .init())
}

