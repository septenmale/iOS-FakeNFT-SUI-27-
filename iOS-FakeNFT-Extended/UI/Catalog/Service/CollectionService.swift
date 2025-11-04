import Foundation

protocol CollectionService {
    func loadCollections() async throws -> [CollectionResponse]
    func loadCollection(id: String) async throws -> CollectionResponse
}

@MainActor
final class CollectionServiceImpl: CollectionService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadCollections() async throws -> [CollectionResponse] {
        let request = CollectionsRequest()
        let collections: [CollectionResponse] = try await networkClient.send(request: request)
        return collections
    }
    
    func loadCollection(id: String) async throws -> CollectionResponse {
        let request = CollectionRequest(id: id)
        let collection: CollectionResponse = try await networkClient.send(request: request)
        return collection
    }
}
