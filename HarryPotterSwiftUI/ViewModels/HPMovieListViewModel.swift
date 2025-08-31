//
//  HPMovieListViewModel.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 06/08/25.
//

import SwiftUI
import Combine

@MainActor
final class HPMovieListViewModel: ObservableObject {
    @Published private(set) var movies: [HPMovie] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    @Published var searchText: String = "" {
        didSet {
            Task {
                if searchText.isEmpty {
                    await fetchMovies()
                } else if searchText.count >= 2 {
                    await searchMovies(query: searchText)
                }
            }
        }
    }
    
    private var currentPage: Int = 1
    private let limit = 50
    private var canLoadMore = true
    
    /// Load all movies
    func fetchMovies() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        currentPage = 1
        canLoadMore = true
        do {
            let newMovies = try await fetchMoviesPage(limit: limit, page: currentPage)
            movies = newMovies
            currentPage += 1
            canLoadMore = !newMovies.isEmpty
        } catch {
            errorMessage = "Failed to load movies: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    /// Get movies page from the API
    private func fetchMoviesPage(limit: Int, page: Int) async throws -> [HPMovie] {
        let request = HPRequest(
            endpoint: .movies,
            queryParameters: [
                URLQueryItem(name: "page[limit]", value: "\(limit)"),
                URLQueryItem(name: "page[number]", value: "\(page)")
            ]
        )
        return try await withCheckedThrowingContinuation { continuation in
            HPService.shared.execute(request, expecting: HPGetAllMoviesResponse.self) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response.data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Search with server (movies by title)
    func searchMovies(query: String) async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        do {
            let request = HPRequest(
                endpoint: .movies,
                queryParameters: [
                    URLQueryItem(name: "filter[title]", value: query),
                    URLQueryItem(name: "page[limit]", value: "50")
                ]
            )
            let results = try await withCheckedThrowingContinuation { continuation in
                HPService.shared.execute(request, expecting: HPGetAllMoviesResponse.self) { result in
                    switch result {
                    case .success(let response): continuation.resume(returning: response.data)
                    case .failure(let error): continuation.resume(throwing: error)
                    }
                }
            }
            if results.isEmpty {
                isLoading = false
                return
            }
            self.movies = results
        } catch {
            errorMessage = "Search failed: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    /// Create Image URL
    func makeImageURL(from urlString: String?) -> URL? {
        urlString.flatMap(URL.init(string:))
    }
}
