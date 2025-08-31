//
//  HPBookListView.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 04/08/25.
//

import SwiftUI

struct HPBookListView: View {
    @ObservedObject var viewModel: HPBookListViewModel
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading && viewModel.books.isEmpty {
                VStack {
                    Spacer()
                    ProgressView("Loading books...")
                        .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 600)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding()
                
            } else if viewModel.books.isEmpty {
                Text("No books found.")
                    .foregroundStyle(.secondary)
                    .padding()
                
            } else {
                ForEach(viewModel.books) { book in
                    NavigationLink {
                        HPBookDetailView(book: book)
                    } label: {
                        HPBookCellView(imageURL: viewModel.makeImageURL(from: book.attributes.cover), name: book.attributes.title, release_date: book.attributes.release_date, pagesCount: book.attributes.pages, authorName: book.attributes.author)
                    }
                }
                
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            
        }
        .navigationTitle("Books")
        .refreshable {
            await viewModel.fetchBooks()
        }
        .task {
            if viewModel.books.isEmpty {
                await viewModel.fetchBooks()
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search books")
    }
}

#Preview {
    HPBookListView(viewModel: .init())
}
