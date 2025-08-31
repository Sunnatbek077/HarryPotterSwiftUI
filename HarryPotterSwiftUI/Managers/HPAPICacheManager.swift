//
//  HPAPICacheManager.swift
//  HarryPotterSwiftUI
//
//  Created by Sunnatbek on 30/07/25.
//

import Foundation

final class HPAPICacheManager {
    
    init() {
        
    }
    
    private var cacheDictionary: [
        HPEndpoint: NSCache<NSString, NSData>
    ] = [:]
    
    // MARK: - Public
    
    /// Get cached API response
    /// - Parameters:
    ///   - endpoint: Endpoint to cache for
    ///   - url: URL key
    /// - Returns: Nullable data
    public func cachedResponse(for endpoint: HPEndpoint, url: URL?) -> Data? {
            guard let targetCache = cacheDictionary[endpoint], let url = url else {
                return nil
            }
            
            let key = url.absoluteString as NSString
            return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: HPEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    // MARK: - Private
    
    /// Set up dictionary
    private func setUpCache() {
        HPEndpoint.allCases.forEach { endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        }
    }
    
}
