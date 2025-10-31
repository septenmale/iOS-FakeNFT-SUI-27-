import SwiftUI
import SwiftData

@Observable
final class CartViewModel {
    private let sortStorage: CartSortStorage
    private let service: CartServiceProtocol
    private let context: ModelContext
    
    var isLoading: Bool = true
    var items: [CartItem] = []
    var selectedSort: CartSortType
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    init(context: ModelContext,
         service: CartServiceProtocol = CartService.shared,
         sortStorage: CartSortStorage = CartSortStorage())
    {
        self.service = service
        self.sortStorage = sortStorage
        self.selectedSort = sortStorage.selectedSort
        self.context = context
    }
    
    @MainActor
    func loadCart() async {
        do {
            isLoading = true
            let loaded = try await loadCartItems()
            items = loaded
            sort(selectedSort)
            isLoading = false
            
        } catch {
            print("Failed to load cart: \(error)")
        }
    }
    
    func loadCartItems() async throws -> [CartItem] {
        
        let descriptor = FetchDescriptor<InCartNft>()
        let savedItems = try context.fetch(descriptor)
        let ids = savedItems.map(\.id)
        
        guard !ids.isEmpty else { return [] }
        let cartItems = try await service.fetchCartItems(by: ids)
        
        return cartItems
        
    }
    
    func removeItem(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
        do {
            let itemIdToDelete = item.id
            let predicate = #Predicate<InCartNft> { nft in
                nft.id == itemIdToDelete
            }
            try context.delete(model: InCartNft.self, where: predicate)
            try context.save()
            
        } catch {
            print("Ошибка удаления NFT \(item.id) из SwiftData: \(error)")
        }
    }
    
    func clearCart() {
        items.removeAll()
        do {
            try context.delete(model: InCartNft.self)
            try context.save()
        } catch {
            print("Ошибка при очистке всех записей InCartNft из SwiftData: \(error)")
        }
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

