import Foundation

struct FetchCurrencyRequest: NetworkRequest {
    var rawBody: Data?
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(CartRequestConstants.currencies)")
    }
}

struct PayOrderRequest: NetworkRequestCart {
    let nfts: [String]
    
    var rawBody: Data? {
        var components = URLComponents()
        components.queryItems = nfts.map { URLQueryItem(name: "nfts", value: $0) }
        return components.percentEncodedQuery?.data(using: .utf8)
    }
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(CartRequestConstants.orders)")
    }
    var httpMethod: HttpMethod { .put }
    var dto: Encodable? { nil }
}

struct FetchNFTByIdRequest: NetworkRequest {
    let id: String
    var rawBody: Data?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)\(CartRequestConstants.nft)\(id)")
    }
    
    var httpMethod: HttpMethod { .get }
    var dto: Encodable? { nil }
}
