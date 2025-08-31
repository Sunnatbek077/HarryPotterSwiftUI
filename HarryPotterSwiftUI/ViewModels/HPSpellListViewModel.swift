//
//  HPSpellListViewModel.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 08/08/25.
//

import SwiftUI
import Combine

@MainActor
final class HPSpellListViewModel: ObservableObject {
    @Published private(set) var spells: [HPSpell] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String? = nil
    
    @Published var searchText: String = "" {
        didSet {
            Task {
                if searchText.isEmpty {
                    await fetchSpells()
                } else if searchText.count >= 2 {
                    await searchSpells(query: searchText)
                }
            }
        }
    }
    
    private var currentPage = 1
    private let limit = 50
    private var canLoadMore: Bool = true
    
    /// Load all spells (from page 1)
    func fetchSpells() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        currentPage = 1
        canLoadMore = true
        do {
            let newSpells = try await fetchSpellsPage(limit: limit, page: currentPage)
            spells = newSpells
            currentPage += 1
            canLoadMore = !newSpells.isEmpty
        } catch {
            errorMessage = "Failed to load characters: \(error.localizedDescription)"
        }
        
        isLoading = false 
    }
    
    
    func loadMoreSpells() async {
        guard !isLoading, canLoadMore else { return }
        isLoading = true
        do {
            let newSpells = try await fetchSpellsPage(limit: limit, page: currentPage)
            guard !newSpells.isEmpty else {
                canLoadMore = false
                isLoading = false
                return 
            }
            spells.append(contentsOf: newSpells)
            currentPage += 1
        } catch {
            errorMessage = "Failed to load more characters: \(error.localizedDescription)"
        }
        
        isLoading = false 
    }
    
    /// Search with server (spells by name)
    func searchSpells(query: String) async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        do {
            let request = HPRequest(
                endpoint: .spells,
                queryParameters: [
                    URLQueryItem(name: "filter[name]", value: query),
                    URLQueryItem(name: "page[limit]", value: "50")
                ]
            )
            let results = try await withCheckedThrowingContinuation { continuation in
                HPService.shared.execute(request, expecting: HPGetAllSpellsResponse.self) { result in
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
            self.spells = results
        } catch {
            errorMessage = "Search failed: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    /// Get spells by page from the API
    func fetchSpellsPage(limit: Int, page: Int) async throws -> [HPSpell] {
        let request = HPRequest(
            endpoint: .spells,
            queryParameters: [
                URLQueryItem(name: "page[limit]", value: "\(limit)"),
                URLQueryItem(name: "page[number]", value: "\(page)")
            ]
        )
        
        return try await withCheckedThrowingContinuation { continuation in
            HPService.shared.execute(request, expecting: HPGetAllSpellsResponse.self) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response.data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// Create image URL
    func makeImageURL(from urlString: String?) ->URL? {
        urlString.flatMap(URL.init(string:))
    }
}
