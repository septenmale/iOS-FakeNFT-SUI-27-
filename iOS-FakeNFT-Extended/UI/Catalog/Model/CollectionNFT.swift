import SwiftUI
import SwiftData

@Model
final class CollectionNFT {
    var id: String
    var name: String
    var like: Bool
    var rating: Int
    var price: Double
    var imageNft: Data?
    var basket: Bool
    
    init(
        id: String,
        name: String? = nil,
        like: Bool = false,
        rating: Int? = nil,
        price: Double? = nil,
        imageNft: Data? = nil,
        basket: Bool = false
    ) {
        self.id = id
        self.name = name ?? "Unknown"
        self.like = like
        self.rating = rating ?? 0
        self.price = price ?? 0.00
        self.imageNft = imageNft
        self.basket = basket
    }
    
    func getID() -> String {
        return id
    }
}
