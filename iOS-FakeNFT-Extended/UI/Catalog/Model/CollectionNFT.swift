import SwiftUI
import SwiftData

@Model
final class CollectionNFT {
    var name: String
    var like: Bool
    var rating: Int
    var price: Int
    var imageNft: String
    var basket: Bool
    
    init(
        name: String,
        like: Bool = false,
        rating: Int,
        price: Int,
        imageNft: String,
        basket: Bool = false
    ) {
        self.name = name
        self.like = like
        self.rating = rating
        self.price = price
        self.imageNft = imageNft
        self.basket = basket
    }
}
