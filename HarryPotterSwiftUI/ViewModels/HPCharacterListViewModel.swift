//
//  HPCharacterListViewModel.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 31/07/25.
//

import SwiftUI
import Combine

@MainActor
final class HPCharacterListViewModel: ObservableObject {
    @Published private(set) var characters: [HPCharacter] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String? = nil
    
    @Published var searchText: String = "" {
        didSet {
            Task {
                // Agar qidiruv bo'sh bo'lsa, asosiy ro'yxatni qaytar
                if searchText.isEmpty {
                    await fetchCharacters()
                }
                // Kamida 2 ta harfdan keyin serverdan qidiruv
                else if searchText.count >= 2 {
                    await searchCharacters(query: searchText)
                }
                // 1 ta harf yozilganda ro'yxatni o'chirmaymiz
            }
        }
    }
    
    private var currentPage = 1
    private let limit = 50
    private var canLoadMore = true
    
    /// Load all characters (from page 1)
    func fetchCharacters() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        currentPage = 1
        canLoadMore = true
        do {
            let newCharacters = try await fetchCharactersPage(limit: limit, page: currentPage)
            characters = newCharacters
            currentPage += 1
            canLoadMore = !newCharacters.isEmpty
        } catch {
            errorMessage = "Failed to load characters: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    /// Search with server
    func searchCharacters(query: String) async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            let request = HPRequest(
                endpoint: .characters,
                queryParameters: [
                    URLQueryItem(name: "filter[name]", value: query)
                ]
            )
            
            let results = try await withCheckedThrowingContinuation { continuation in
                HPService.shared.execute(request, expecting: HPGetAllCharactersResponse.self) { result in
                    switch result {
                    case .success(let response):
                        continuation.resume(returning: response.data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
            // Natija bo'sh bo'lsa ham, characters ni tozalab yubormaymiz
            if results.isEmpty {
                return
            }
            self.characters = results
            self.canLoadMore = false
        } catch {
            errorMessage = "Search failed: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    /// Load additional pages (pagination)
    func loadMoreCharacters() async {
        guard !isLoading, canLoadMore, searchText.isEmpty else { return }
        isLoading = true
        do {
            let newCharacters = try await fetchCharactersPage(limit: limit, page: currentPage)
            guard !newCharacters.isEmpty else {
                canLoadMore = false
                isLoading = false
                return
            }
            characters.append(contentsOf: newCharacters)
            currentPage += 1
        } catch {
            errorMessage = "Failed to load more characters: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    /// Get characters by page from the API
    private func fetchCharactersPage(limit: Int, page: Int)  async throws -> [HPCharacter] {
        let request = HPRequest(
            endpoint: .characters,
            queryParameters: [
                URLQueryItem(name: "page[limit]", value: "\(limit)"),
                URLQueryItem(name: "page[number]", value: "\(page)")
            ]
        )
        return try await withCheckedThrowingContinuation { continuation in
            HPService.shared.execute(request, expecting: HPGetAllCharactersResponse.self) { result in
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
    func makeImageURL(from urlString: String?) -> URL? {
        urlString.flatMap(URL.init(string:))
    }
}
