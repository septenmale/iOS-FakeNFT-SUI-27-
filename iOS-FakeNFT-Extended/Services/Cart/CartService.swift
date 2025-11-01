enum CartServiceError: Error {
    case fetchCurrencyError
    case payOrderError
    case fetchNFTError
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
    
    func fetchCartItems(by ids: [String]) async throws -> [CartItem] {
        try await withThrowingTaskGroup(of: CartItem.self) { group in
            for id in ids {
                group.addTask {
                    let request = FetchNFTByIdRequest(id: id)
                    return try await self.networkClient.send(request: request)
                }
            }
            var result: [CartItem] = []
            for try await item in group {
                result.append(item)
            }
            return result
        }
    }
}
