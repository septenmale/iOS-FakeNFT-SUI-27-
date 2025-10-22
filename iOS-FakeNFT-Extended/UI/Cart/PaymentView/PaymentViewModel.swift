import SwiftUI

@Observable
final class PaymentViewModel {
    var currencies: [Currency] = MockСurrencies.сurrencies
    var selectedCurrencyId: String = ""
    
    let cartItems: [CartItem]
    
    init(cartItems: [CartItem]) {
        self.cartItems = cartItems
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

struct MockСurrencies {
    static let сurrencies: [Currency] = [
        Currency(id: "1", title: "Bitcoin", name: "ВТС", image: "https://"),
        Currency(id: "2", title: "Dogecoin", name: "DOGE", image: "https://"),
        Currency(id: "3", title: "Tether", name: "USDT", image: "https://"),
        Currency(id: "4", title: "Apecoin", name: "APE", image: "https://")
    ]
}
