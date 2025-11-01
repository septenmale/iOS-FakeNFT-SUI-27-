//
//  UserNFTCollectionModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/25/25.
//
import Foundation

actor UserNFTCollectionModel: UserNFTCollectionModelProtocol {
    
    func fetchUserCollection(idsArray nfts: [String]) async throws -> [UserCollectionNFTJsonModel] {
        var result: [UserCollectionNFTJsonModel] = []
        for nft in nfts {
            let urlString = "\(RequestConstants.baseURL)/api/v1/nft/\(nft)"
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
            
            result.append(try await provider.fetchDataWithDecoding())
        }
        return result
    }
    
    func fetchNftImage(urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        let provider = CommonDataProvider(request: URLRequest(url: url))
        
        let result = try await provider.fetchData()
        
        return result
    }
}

protocol UserNFTCollectionModelProtocol {
    func fetchUserCollection(idsArray nfts: [String]) async throws -> [UserCollectionNFTJsonModel]
}

