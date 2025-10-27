//
//  UserNFTCollectionModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/25/25.
//
import Foundation

struct UserCollectionNFTItem: Codable, Sendable {
    let id: String
    let name: String
    let rating: Int
    let price: Double
    let imageData: Data?
    
    init(
        id: String,
        name: String? = nil,
        rating: Int? = nil,
        price: Double? = nil,
        imageData: Data? = nil,
        like: Bool = false,
        basket: Bool = false
    ) {
        self.id = id
        self.name = name ?? "Unknown"
        self.rating = rating ?? 0
        self.price = price ?? 0.00
        self.imageData = imageData
    }
    
    func getID() -> String {
        return id
    }
}

//MARK: Будет сделано в эпике 3/3
actor UserNFTCollectionModel: UserNFTCollectionModelProtocol {
    func fetchUserCollection() async throws -> [UserCollectionNFTItem] {
        return []
    }
}

actor UserNFTCollectionModelMock: UserNFTCollectionModelProtocol {
    private let collection: [UserCollectionNFTItem] =
    [UserCollectionNFTItem(id: "randomID", name: "Hornet", rating: 5, price: 100), UserCollectionNFTItem(id: "anotherRandomID", name: "Trobbio", rating: 2, price: 11),
     UserCollectionNFTItem(id: "lastRandomID", name: "Lace", rating: 4, price: 99.99),
     UserCollectionNFTItem(id: "randomIDD", name: "Mrs Kitty", rating: 1, price: 1),
     UserCollectionNFTItem(id: "anotherRandomIDD", name: "Goose", rating: 3, price: 15.66),
     UserCollectionNFTItem(id: "lastRandomIDD", name: "Who?", rating: 2, price: 2.01)
    ]
    
    func fetchUserCollection() async throws -> [UserCollectionNFTItem] {
        sleep(3)
        return collection
    }
}

protocol UserNFTCollectionModelProtocol {
    func fetchUserCollection() async throws -> [UserCollectionNFTItem]
}

