import Foundation

protocol CartServiceProtocol {
    func fetchCurrencies() async throws -> [Currency]
    func payOrder(nftIds: [String]) async throws
    func fetchCartItems(by ids: [String]) async throws -> [CartItem]
}
