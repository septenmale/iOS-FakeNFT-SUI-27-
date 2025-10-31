//
//  StatsModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/30/25.
//

import Foundation

struct UserStatsJsonModel: Sendable, Decodable, Identifiable {
    let name: String?
    let avatar: String?
    let description: String?
    let website: String?
    let nfts: [String]?
    let rating: String?
    let id: String?
}

enum APIError: Error {
    case invalidURL
    case responseConvertationError
    case badResponse(Int)
    case decodingFailed
    case networkError
}

actor StatsModel: StatsModelProtocol {
    
    private var fetchedImages: [String: Data] = [:]
    
    func fetchUserStats() async throws -> [UserStatsJsonModel] {
        let urlString = "\(RequestConstants.baseURL)/api/v1/users"
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        let request = {
            var request = URLRequest(url: url)
            request.addValue(RequestConstants.token, forHTTPHeaderField: "X-Practicum-Mobile-Token")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            return request
        }()
        
        let provider = CommonDataProvider(request: request)
        
        return try await provider.fetchDataWithDecoding()
    }
    
    func fetchUserImage(urlString: String) async throws -> Data {
        let storedImage = fetchedImages[urlString]
        
        if let storedImage {
            return storedImage
        }
        
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        let provider = CommonDataProvider(request: URLRequest(url: url))
        
        let result = try await provider.fetchData()
        
        fetchedImages[urlString] = result
        
        return result
    }
}

protocol StatsModelProtocol {
    func fetchUserStats() async throws -> [UserStatsJsonModel]
    func fetchUserImage(urlString: String) async throws -> Data
}
