//
//  HPSearchViewModel.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 26/08/25.
//

import Foundation
import Combine

final class HPSearchViewModel: ObservableObject {
    @Published var books: [HPBook] = []
    @Published var characters: [HPCharacter] = []
    @Published var movies: [HPMovie] = []
    @Published var potions: [HPPotion] = []
    @Published var spells: [HPSpell] = []
    @Published var rawNames: [String] = []
    @Published var searchTask: Task<Void, Never>?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var rawResponse: String?
    
    private let service = HPService.shared
    
    func clearResults() {
        books = []
        characters = []
        movies = []
        potions = []
        spells = []
        rawNames = []
    }
    
    // MARK: - Universal search
    private func search<T: Codable>(
        endpoint: HPEndpoint,
        query: String,
        expecting type: T.Type
    ) async -> T? {
        isLoading = true
        errorMessage = nil
        
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            isLoading = false
            return nil
        }
        
        let queryParameters: [URLQueryItem]
        switch endpoint {
        case .books, .movies:
            queryParameters = [
                URLQueryItem(name: "filter[title_cont]", value: query),
                URLQueryItem(name: "page[size]", value: "50"),
                URLQueryItem(name: "page[number]", value: "1")
            ]
        case .characters, .potions, .spells:
            queryParameters = [
                URLQueryItem(name: "filter[name_cont]", value: query),
                URLQueryItem(name: "page[size]", value: "50"),
                URLQueryItem(name: "page[number]", value: "1")
            ]
        }
        
        let request = HPRequest(endpoint: endpoint, queryParameters: queryParameters)
        print("🔎 Request URL:", request.url?.absoluteString ?? "nil")
        
        
        
        do {
            // 🔹 RAW JSON olish (faqat debug/ko‘rsatish uchun)
            if let url = request.url {
                let (data, _) = try await URLSession.shared.data(from: url)
                let raw = String(data: data, encoding: .utf8)
                await MainActor.run {
                    self.rawResponse = raw
                    
                    // JSONdan faqat "name"/"title"larni yig‘ib olish
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let items = json["data"] as? [[String: Any]] {
                        self.rawNames = items.compactMap { item in
                            guard let attrs = item["attributes"] as? [String: Any] else { return nil }
                            return attrs["name"] as? String ?? attrs["title"] as? String
                        }
                    }
                }
            }
            
            // 🔹 Asl service chaqiruvi (model decode uchun)
            let result: T = try await withCheckedThrowingContinuation { continuation in
                service.execute(request, expecting: T.self) { completion in
                    switch completion {
                    case .success(let decoded):
                        continuation.resume(returning: decoded)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
            
            isLoading = false
            return result
        } catch {
            print("❌ Decode error:", error.localizedDescription)
            if let url = request.url {
                print("🔎 Request URL again:", url.absoluteString)
            }
            self.errorMessage = error.localizedDescription
            self.isLoading = false
            return nil
        }
    }
    
    // MARK: - Universal parallel qidiruv boshqa usul
    @MainActor func searchAll(query: String) {
        Task { @MainActor in
            let endpoints: [(HPEndpoint, Any.Type)] = [
                (.books, HPGetAllBooksResponse.self),
                (.characters, HPGetAllCharactersResponse.self),
                (.movies, HPGetAllMoviesResponse.self),
                (.potions, HPGetAllPotionsResponse.self),
                (.spells, HPGetAllSpellsResponse.self)
            ]
            await withTaskGroup(of: Void.self) { group in
                for (endpoint, _) in endpoints {
                    group.addTask { @MainActor in
                        switch endpoint {
                        case .books:
                            if let result: HPGetAllBooksResponse = await self.search(endpoint: .books, query: query, expecting: HPGetAllBooksResponse.self) {
                                self.books = result.data
                            }
                        case .characters:
                            if let result: HPGetAllCharactersResponse = await self.search(endpoint: .characters, query: query, expecting: HPGetAllCharactersResponse.self) {
                                self.characters = result.data
                            }
                        case .movies:
                            if let result: HPGetAllMoviesResponse = await self.search(endpoint: .movies, query: query, expecting: HPGetAllMoviesResponse.self) {
                                self.movies = result.data
                            }
                        case .potions:
                            if let result: HPGetAllPotionsResponse = await self.search(endpoint: .potions, query: query, expecting: HPGetAllPotionsResponse.self) {
                                self.potions = result.data
                            }
                        case .spells:
                            if let result: HPGetAllSpellsResponse = await self.search(endpoint: .spells, query: query, expecting: HPGetAllSpellsResponse.self) {
                                self.spells = result.data
                            }
                        }
                    }
                }
            }
        }
    }
}
