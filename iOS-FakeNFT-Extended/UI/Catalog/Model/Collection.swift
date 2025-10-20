import SwiftUI
import SwiftData

@Model
final class Collection {
    var name: String
    var like: Bool
    var rating: Double
    var price: Int
    var imageNft: String
    var basket: Bool
    
    init(
        name: String,
        like: Bool = false,
        rating: Double,
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
