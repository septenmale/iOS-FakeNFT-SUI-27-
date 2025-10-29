enum CartServiceError: Error {
    case fetchCurrencyError
    case payOrderError
}

final class CartService: CartServiceProtocol {
    static let shared = CartService()
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchCurrencies() async throws -> [Currency] {
        let request = FetchCurrencyRequest()
        do {
            return try await networkClient.send(request: request)
        } catch {
            throw CartServiceError.fetchCurrencyError
        }
    }
    
    func payOrder(nftIds: [String]) async throws {
        let request = PayOrderRequest(nfts: nftIds)
        do {
            _ = try await networkClient.sendCart(request: request)
        } catch {
            throw CartServiceError.payOrderError
        }
    }
}

