import Foundation

enum APIError: Error {
    case invalidURL
    case responseConvertationError
    case badResponse(Int)
    case decodingFailed
    case networkError
}

actor StatsModel: StatsModelProtocol {
    
    private var fetchedImages: [String: Data] = [:]
    
    func fetchUserStats() async throws -> [UserStatsJsonModel] {
        let urlString = "\(RequestConstants.baseURL)/api/v1/users"
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        let request = {
            var request = URLRequest(url: url)
            request.addValue(RequestConstants.token, forHTTPHeaderField: "X-Practicum-Mobile-Token")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            return request
        }()
        
        let provider = CommonDataProvider(request: request)
        
        return try await provider.fetchDataWithDecoding()
    }
    
    func fetchUserImage(urlString: String) async throws -> Data {
        let storedImage = fetchedImages[urlString]
        
        if let storedImage {
            return storedImage
        }
        
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.timeoutInterval = 5
            return request
        }()
        
        let provider = CommonDataProvider(request: request)
        
        let result = try await provider.fetchData()
        
        fetchedImages[urlString] = result
        
        return result
    }
    
    func fetchUserStatsWithImages() async throws -> [User] {
        let userJsonModels = try await fetchUserStats()
        
        let usersWithImages: [User] = await withTaskGroup(of: User.self) { group in
            for user in userJsonModels {
                group.addTask {
                    guard let avatar = user.avatar else {
                        return User(from: user, imageData: nil)
                    }
                    let imageData = try? await self.fetchUserImage(urlString: avatar)
                    
                    return User(from: user, imageData: imageData)
                }
            }
            var result = [User]()
            for await user in group {
                result.append(user)
            }
            return result
        }
        return usersWithImages
    }
}

protocol StatsModelProtocol {
    func fetchUserStats() async throws -> [UserStatsJsonModel]
    func fetchUserImage(urlString: String) async throws -> Data
    func fetchUserStatsWithImages() async throws -> [User]
}
