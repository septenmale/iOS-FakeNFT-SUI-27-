import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let imageURL: String
    let name: String
    let rating: Int
    let price: Double
}


