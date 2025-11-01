import Foundation

// Запрос для получения всех коллекций
struct CollectionsRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/collections")
    }
}
