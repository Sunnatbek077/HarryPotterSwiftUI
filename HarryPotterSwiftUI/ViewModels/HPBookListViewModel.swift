//
//  HPBookListViewModel.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 04/08/25.
//

import SwiftUI
import Combine

@MainActor
final class HPBookListViewModel: ObservableObject {
    @Published private(set) var books: [HPBook] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String? = nil
    
    @Published var searchText: String = "" {
        didSet {
            Task {
                if searchText.isEmpty {
                    await fetchBooks()
                } else if searchText.count >= 2 {
                    await searchBooks(query: searchText)
                }
            }
        }
    }
    
    private var currentPage = 1
    private let limit = 50
    private var canLoadMore = true
    
    /// Load all books
    func fetchBooks() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        currentPage = 1
        canLoadMore = true
        do {
            let newbooks = try await fetchBooksPage(limit: limit, page: currentPage)
            books = newbooks
            currentPage += 1
            canLoadMore = !newbooks.isEmpty
        } catch {
            errorMessage = "Failed to load books: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    /// Get books by page from the API
    private func fetchBooksPage(limit: Int, page: Int)  async throws -> [HPBook] {
        let request = HPRequest(
            endpoint: .books,
            queryParameters: [
                URLQueryItem(name: "page[limit]", value: "\(limit)"),
                URLQueryItem(name: "page[number]", value: "\(page)")
            ]
        )
        return try await withCheckedThrowingContinuation { continuation in
            HPService.shared.execute(request, expecting: HPGetAllBooksResponse.self) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response.data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Search with server (books by title)
    func searchBooks(query: String) async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            let request = HPRequest(
                endpoint: .books,
                queryParameters: [
                    URLQueryItem(name: "filter[title]", value: query),
                    URLQueryItem(name: "page[limit]", value: "50")
                ]
            )
            let results = try await withCheckedThrowingContinuation { continuation in
                HPService.shared.execute(request, expecting: HPGetAllBooksResponse.self) { result in
                    switch result {
                    case .success(let response): continuation.resume(returning: response.data)
                    case .failure(let error): continuation.resume(throwing: error)
                    }
                }
            }
            if results.isEmpty {
                // Keep existing list if nothing found
                isLoading = false
                return
            }
            self.books = results
        } catch {
            errorMessage = "Search failed: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    /// Create image URL
    func makeImageURL(from urlString: String?) -> URL? {
        urlString.flatMap(URL.init(string:))
    }
    
}

