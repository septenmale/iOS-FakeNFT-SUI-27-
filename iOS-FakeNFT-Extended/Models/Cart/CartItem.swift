import Foundation

struct CartItem:Identifiable, Codable, Hashable  {
//    let idUUID = UUID()
    let id: String
    let imageURL: String
    let name: String
    let rating: Int
    let price: Double
}


