//
//  UserStatsJsonModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 11/1/25.
//

struct UserStatsJsonModel: Sendable, Decodable, Identifiable {
    let name: String?
    let avatar: String?
    let description: String?
    let website: String?
    let nfts: [String]?
    let rating: String?
    let id: String?
}
