//
//  HPPotionListViewModel.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 07/08/25.
//

import SwiftUI
import Combine

@MainActor
final class HPPotionListViewModel: ObservableObject {
    @Published private(set) var potions: [HPPotion] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    @Published var searchText: String = "" {
        didSet {
            Task {
                if searchText.isEmpty {
                    await fetchPotions()
                } else if searchText.count >= 2 {
                    await searchPotions(query: searchText)
                }
            }
        }
    }
    
    private var currentPage: Int = 1
    private let limit = 50
    private var canLoadMore = true
    
    func fetchPotions() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        currentPage = 1
        canLoadMore = true
        do {
            let newPotions = try await fetchPotionPages(limit: limit, page: currentPage)
            potions = newPotions
            currentPage += 1
            canLoadMore = !newPotions.isEmpty
        } catch {
            errorMessage = "Failed to load potions: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    /// Get potions page from the API
    func fetchPotionPages(limit: Int, page: Int) async throws -> [HPPotion] {
        let request = HPRequest(endpoint: .potions,
                                queryParameters: [
                                    URLQueryItem(name: "page[limit]", value: "\(limit)"),
                                    URLQueryItem(name: "page[number]", value: "\(page)")
                                ]
        )
        return try await withCheckedThrowingContinuation { continuation in
            HPService.shared.execute(request, expecting: HPGetAllPotionsResponse.self) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response.data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Search with server (potions by name)
    func searchPotions(query: String) async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        do {
            let request = HPRequest(
                endpoint: .potions,
                queryParameters: [
                    URLQueryItem(name: "filter[name]", value: query),
                    URLQueryItem(name: "page[limit]", value: "50")
                ]
            )
            let results = try await withCheckedThrowingContinuation { continuation in
                HPService.shared.execute(request, expecting: HPGetAllPotionsResponse.self) { result in
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
            self.potions = results
        } catch {
            errorMessage = "Search failed: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func makeImageURL(from urlString: String?) -> URL? {
        urlString.flatMap(URL.init(string:))
    }
    
    func loadMorePotions() async {
        guard !isLoading, canLoadMore else { return }
        isLoading = true
        
        do {
            let newPotions = try await fetchPotionPages(limit: limit, page: currentPage)
            guard !newPotions.isEmpty else {
                canLoadMore = false
                isLoading = false
                return
            }
            potions.append(contentsOf: newPotions)
            currentPage += 1
        } catch {
            errorMessage = "Failed to load more characters: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
