import SwiftUI

@Observable
final class PaymentViewModel {
    private let service: CartServiceProtocol
    var isLoading: Bool = false
    
    var currencies: [Currency] = []
    var selectedCurrencyId: String = ""
    
    let cartItemsId: [String]
    
    init(service: CartServiceProtocol = CartService.shared, cartItemsId: [String]) {
        self.service = service
        self.cartItemsId = cartItemsId
        Task { await loadCurrency() }
    }
    
    @MainActor
    func loadCurrency() async {
        guard currencies.isEmpty else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            currencies = try await service.fetchCurrencies()
            print("Валюты загружены:", currencies.count)
        } catch {
            print("Ошибка при загрузке валют:", error)
        }
    }
    
    func selectCurrency(_ currency: Currency) {
        guard selectedCurrencyId != currency.id else { return }
        selectedCurrencyId = currency.id
    }
    
    func payOrder() async -> Bool {
        guard !selectedCurrencyId.isEmpty else {
            return false
        }
        do {
            try await service.payOrder(nftIds: cartItemsId)
            return true
        } catch {
            if let error = error as? NetworkClientError {
                switch error {
                case .httpStatusCode(let code):
                    print("Сервер вернул код \(code) при оплате")
                case .urlRequestError(let err):
                    print("Ошибка формирования запроса: \(err.localizedDescription)")
                case .urlSessionError:
                    print("Ошибка сети или URLSession")
                case .parsingError:
                    print("Ошибка парсинга ответа")
                case .incorrectRequest(let msg):
                    print("Некорректный запрос: \(msg)")
                }
            } else {
                print("Неизвестная ошибка: \(error.localizedDescription)")
            }
            return false
        }
    }
}


