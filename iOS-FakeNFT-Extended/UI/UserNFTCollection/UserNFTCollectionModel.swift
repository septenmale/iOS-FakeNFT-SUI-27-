//
//  UserNFTCollectionModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/25/25.
//
import Foundation

struct UserCollectionNFTItem {
    let id: String
    let name: String
    let rating: Int
    let price: Double
    let imageUrl: URL?
    
    init(
        id: String,
        name: String? = nil,
        rating: Int? = nil,
        price: Double? = nil,
        imageUrl: URL? = nil,
    ) {
        self.id = id
        self.name = name ?? "Unknown"
        self.rating = rating ?? 0
        self.price = price ?? 0.00
        self.imageUrl = imageUrl
    }
    
    init(from model: UserCollectionNFTJsonModel) {
        self.id = model.id ?? ""
        self.name = model.name ?? ""
        self.price = model.price ?? 0.00
        self.rating = model.rating ?? 0
        guard let imageUrlString = model.images?.first else {
            self.imageUrl = nil
            return
        }
        self.imageUrl = URL(string: imageUrlString)
    }
}

struct UserCollectionNFTJsonModel: Sendable, Decodable, Identifiable {
    let createdAt: String?
    let name: String?
    let images: [String]?
    let rating: Int?
    let description: String?
    let price: Double?
    let author: String?
    let id: String?
}

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

