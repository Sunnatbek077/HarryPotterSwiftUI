//
//  HPService.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 28/07/25.
//

import Foundation

final class HPService {
    static let shared = HPService()
    
    private let cacheManager = HPAPICacheManager()
    
    private init() {
        
    }
    
    enum HPServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(
        _ request: HPRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        if let cachedData = cacheManager.cachedResponse(
            for: request.endpoint,
            url: request.url
        ) {
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(HPServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self, type] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? HPServiceError.failedToGetData))
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📩 RAW RESPONSE for \(request.endpoint):\n\(jsonString)")
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(
                    for: request.endpoint,
                    url: request.url,
                    data: data
                )
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    // MARK: - Private
    
    private func request(from hpRequest: HPRequest) -> URLRequest? {
        guard let url = hpRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = hpRequest.httpMethod
        return request
    }
}

