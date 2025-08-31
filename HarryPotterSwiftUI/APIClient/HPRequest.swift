//
//  HPRequest.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 28/07/25.
//

import Foundation

final class HPRequest {
    private struct Constants {
        static let baseUrl = "https://api.potterdb.com/v1"
    }
    
    /// Desired Endpoint
    let endpoint: HPEndpoint
    
    /// Path Components for API, if any
    private let pathComponents: [String]
    
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    // MARK: - Public
    
    /// Computed & constructed API url
    public var url: URL? {
        guard var components = URLComponents(string: Constants.baseUrl) else { return nil }
        var path = components.path // preserve "/v1"
        if !path.hasSuffix("/") { path += "/" }
        path += endpoint.rawValue
        if !pathComponents.isEmpty {
            pathComponents.forEach { path += "/\($0)" }
        }
        components.path = path
        if !queryParameters.isEmpty {
            components.queryItems = queryParameters
        }
        return components.url
    }
    
    /// Desired HTTP Method
    public let httpMethod: String = "GET"
    
    /// Construction request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path Components
    ///   - queryParameters: Collection of Query Parameters
    public init(
        endpoint: HPEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl + "/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0] // Endpoint
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                
                if let hpEndpoint = HPEndpoint(
                    rawValue: endpointString
                ) {
                    self.init(endpoint: hpEndpoint, pathComponents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty {
                let endpointString = components[0]
                let queryItemsString = components.count > 1 ? components[1] : ""
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    let name = parts[0]
                    let value = parts.count > 1 ? parts[1] : nil
                    return URLQueryItem(
                        name: name,
                        value: value
                    )
                })
                
                if let hpEndpoint = HPEndpoint(
                    rawValue: endpointString
                ) {
                    self.init(endpoint: hpEndpoint, queryParameters: queryItems)
                    return
                }
            }
        } else {
            if let hpEndpoint = HPEndpoint(rawValue: trimmed) {
                self.init(endpoint: hpEndpoint)
            }
        }
        
        return nil
    }
}

extension HPRequest {
    static let listCharacterRequest = HPRequest(endpoint: .characters)
    static let listBooksRequest = HPRequest(endpoint: .books)
    static let listMoviesRequest = HPRequest(endpoint: .movies)
    static let listPotionsRequest = HPRequest(endpoint: .potions)
    static let listSpellsRequest = HPRequest(endpoint: .spells)
}
