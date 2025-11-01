//
//  User.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 11/1/25.
//

import SwiftUI

@Observable class User: Identifiable {
    let id: String
    let name: String
    var imageData: Data?
    let description: String
    let website: String
    let NFTCollectionIDs: [String]
    let NFTCount: Int
    var isLoadingImage: Bool = false
    
    init(id: String = UUID().uuidString, name: String? = nil, imageData: Data? = nil, description: String? = nil, website: String? = nil, NFTCollectionIDs: [String]? = nil, NFTCount: Int? = nil) {
        self.id = id
        self.name = name ?? "Unknown User"
        self.imageData = imageData
        self.description = description ?? "No Description"
        self.website = website ?? "https://practicum.yandex.ru/"
        self.NFTCollectionIDs = NFTCollectionIDs ?? []
        self.NFTCount = NFTCount ?? 0
    }
    
    init(from model: UserStatsJsonModel, imageData: Data? = nil) {
        id = model.id ?? UUID().uuidString
        name = model.name ?? "Unknown User"
        self.imageData = imageData
        description = model.description ?? "No Description"
        website = model.website ?? "https://practicum.yandex.ru/"
        NFTCollectionIDs = model.nfts ?? []
        NFTCount = model.nfts?.count ?? 0
    }
}
