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
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        let provider = CommonDataProvider(request: URLRequest(url: url))
        
        return try await provider.fetchData()
    }
}

class CommonDataProvider {
    let request: URLRequest
    
    init(request: URLRequest) {
        self.request = request
    }
    
    func fetchDataWithDecoding<T: Decodable>() async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.responseConvertationError
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.badResponse(httpResponse.statusCode)
        }
        
        let decoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            return decoder
        }()
        
        guard let result = try? decoder.decode(T.self, from: data) else {
            throw APIError.decodingFailed
        }
        
        return result
    }
    
    func fetchData() async throws -> Data {

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.responseConvertationError
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.badResponse(httpResponse.statusCode)
        }
        
        return data
    }
}

protocol StatsModelProtocol {
    func fetchUserStats() async throws -> [UserStatsJsonModel]
    func fetchUserImage(urlString: String) async throws -> Data
}
