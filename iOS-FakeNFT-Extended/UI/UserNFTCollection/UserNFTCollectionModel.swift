//
//  UserNFTCollectionModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/25/25.
//
import Foundation

actor UserNFTCollectionModel: UserNFTCollectionModelProtocol {
    
    func fetchUserCollection(idsArray nfts: [String]) async throws -> [UserCollectionNFTJsonModel] {
        let result: [UserCollectionNFTJsonModel] = try await withThrowingTaskGroup(of: UserCollectionNFTJsonModel?.self) { group in
            var result: [UserCollectionNFTJsonModel] = []
            for nft in nfts {
                group.addTask {
                    try await self.fetchUserNft(nftId: nft)
                }
            }
            
            for try await item in group {
                guard let item else {
                    continue
                }
                result.append(item)
            }
            return result
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
    
    private func fetchUserNft(nftId: String) async throws -> UserCollectionNFTJsonModel {
        let urlString = "\(RequestConstants.baseURL)/api/v1/nft/\(nftId)"
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
}

protocol UserNFTCollectionModelProtocol {
    func fetchUserCollection(idsArray nfts: [String]) async throws -> [UserCollectionNFTJsonModel]
}

