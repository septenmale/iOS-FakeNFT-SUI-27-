import Foundation

struct CartItem: Identifiable, Decodable, Hashable {
    let id: String
    let name: String
    let rating: Int
    let price: Double
    let images: [String]
    
    var imageURL: String {
        images.first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
}

