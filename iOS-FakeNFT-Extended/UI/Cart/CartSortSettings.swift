import SwiftUI

enum CartSortType: String, CaseIterable, Identifiable {
    case price = "By price"
    case rating = "By rating"
    case name = "By name"
    
    var id: String { self.rawValue }
}

final class CartSortStorage: ObservableObject {
    @AppStorage(Keys.selectedSortType) private var sortTypeRawValue: String = CartSortType.name.rawValue

    var selectedSort: CartSortType {
        get { CartSortType(rawValue: sortTypeRawValue) ?? .name }
        set { sortTypeRawValue = newValue.rawValue }
    }
}

private extension CartSortStorage {
    enum Keys {
        static let selectedSortType = "selectedCartSortType"
    }
}
