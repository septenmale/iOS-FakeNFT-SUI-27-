//
//  UserCollectionNFTJsonModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 11/1/25.
//

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
