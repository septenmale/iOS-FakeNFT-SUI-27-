import SwiftUI

@Observable
final class CartViewModel {
   
    var items: [CartItem] = MockItems.items
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    func removeItem(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
}

struct MockItems {
    static let items: [CartItem] = [
        CartItem(imageURL: "https://", name: "April", rating: 1, price: 1.78),
        CartItem(imageURL: "https://", name: "Greena", rating: 3, price: 3.08),
        CartItem(imageURL: "https://", name: "Spring", rating: 5, price: 2.10)
    ]
}
