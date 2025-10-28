import SwiftUI

@Observable
final class PaymentViewModel {
    private let service: CartServiceProtocol
    var isLoading: Bool = false
    
    var currencies: [Currency] = []
    var selectedCurrencyId: String = ""
    
    let cartItems: [CartItem]
    
    init(service: CartServiceProtocol = CartService.shared, cartItems: [CartItem]) {
        self.service = service
        self.cartItems = cartItems
        loadCurrency()
    }
    
    func loadCurrency() {
        if currencies.isEmpty {
            isLoading = true
            Task {
                defer {
                    Task { @MainActor in self.isLoading = false }
                }
                do {
                    self.currencies = try await service.fetchCurrencies()
                } catch {
                    print("При загрузке валют произошла ошибка: \(error)")
                }
            }
        }
    }
    
    func selectCurrency(_ currency: Currency) {
        guard selectedCurrencyId != currency.id else { return }
        selectedCurrencyId = currency.id
    }
    
    func payOrder() async -> Bool { //Заглушка пока не подключены запросы
        guard !selectedCurrencyId.isEmpty else {
            return false
        }
        try? await Task.sleep(for: .seconds(1))
        return Bool.random() 
    }
}

