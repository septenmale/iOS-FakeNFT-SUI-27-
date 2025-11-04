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
