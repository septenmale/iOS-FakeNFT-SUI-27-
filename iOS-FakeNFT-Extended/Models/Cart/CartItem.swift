import Foundation

struct CartItem: Identifiable, Decodable, Hashable {
    let id: String
    let name: String
    let rating: Int
    let price: Double
    let imageURL: String 

    enum CodingKeys: String, CodingKey {
        case id, name, rating, price, images
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decode(Int.self, forKey: .rating)
        price = try container.decode(Double.self, forKey: .price)
        let images = try container.decodeIfPresent([String].self, forKey: .images)
        imageURL = images?.first ?? ""
    }
}
