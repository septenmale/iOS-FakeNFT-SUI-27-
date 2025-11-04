import Foundation

// Модель для коллекции из API
struct CollectionResponse: Decodable {
    let id: String
    let name: String
    let cover: String
    let nfts: [String]
    let description: String
    let author: String
}

// Модель для NFT из API
struct NftResponse: Decodable {
    let id: String
    let name: String
    let images: [URL]
    let rating: Int
    let price: Double
}
