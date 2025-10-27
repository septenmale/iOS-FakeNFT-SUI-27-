import SwiftUI

@Observable
final class CartViewModel {
   
    var items: [CartItem]
    private let sortStorage: CartSortStorage
    var selectedSort: CartSortType
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    init(items: [CartItem] = MockItems.items, sortStorage: CartSortStorage = CartSortStorage()) {
        self.items = items
        self.sortStorage = sortStorage
        self.selectedSort = sortStorage.selectedSort
        sort(selectedSort)
    }
    
    func removeItem(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    func selectSort(_ type: CartSortType) {
        selectedSort = type
        sortStorage.selectedSort = type
        sort(type)
    }
    
    private func sort(_ type: CartSortType) {
        switch type {
        case .price:
            items.sort { $0.price < $1.price }
        case .rating:
            items.sort { $0.rating > $1.rating }
        case .name:
            items.sort { $0.name < $1.name }
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
