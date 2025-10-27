import Foundation

protocol CartServiceProtocol {
    func fetchCurrencies() async throws -> [Currency]
}
