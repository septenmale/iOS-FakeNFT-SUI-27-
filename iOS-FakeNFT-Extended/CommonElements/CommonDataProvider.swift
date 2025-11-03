//
//  CommonDataProvider.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/31/25.
//

import Foundation

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
