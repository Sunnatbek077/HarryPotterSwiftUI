//
//  SearchView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 29/08/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchViewModel = HPSearchViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                // Loading indicator
                if searchViewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.1)
                            .padding(.vertical, 8)
                            .accessibilityLabel("Loading…")
                        Spacer()
                    }
                } else if !searchViewModel.rawNames.isEmpty {
                    Section("From RAW Response") {
                        ForEach(searchViewModel.rawNames, id: \.self) { name in
                            Text(name)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText)
            .onChange(of: searchText) { _, newValue in
                // Debounce using DispatchQueue
                NSObject.cancelPreviousPerformRequests(withTarget: searchViewModel)
                if !newValue.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if newValue == searchText {
                            Task {
                                searchViewModel.searchAll(query: newValue)
                            }
                        }
                    }
                } else {
                    searchViewModel.clearResults()
                }
            }
        }
    }
}
#Preview {
    SearchView()
}

