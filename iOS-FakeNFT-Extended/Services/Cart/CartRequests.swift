import Foundation

struct FetchCurrencyRequest: NetworkRequest {
    var rawBody: Data?
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(CartRequestConstants.currencies)")
    }
}
