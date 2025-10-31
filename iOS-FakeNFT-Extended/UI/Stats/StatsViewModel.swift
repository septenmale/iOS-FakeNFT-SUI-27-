//
//  StatsViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/14/25.
//

import SwiftUI

@Observable class User: Identifiable {
    let id: String
    let name: String
    var imageData: Data?
    let description: String
    let website: String
    let NFTCollectionIDs: [String]
    let NFTCount: Int
    var isLoadingImage: Bool = false
    
    init(id: String = UUID().uuidString, name: String? = nil, imageData: Data? = nil, description: String? = nil, website: String? = nil, NFTCollectionIDs: [String]? = nil, NFTCount: Int? = nil) {
        self.id = id
        self.name = name ?? "Unknown User"
        self.imageData = imageData
        self.description = description ?? "No Description"
        self.website = website ?? "https://practicum.yandex.ru/"
        self.NFTCollectionIDs = NFTCollectionIDs ?? []
        self.NFTCount = NFTCount ?? 0
    }
    
    init(from model: UserStatsJsonModel, imageData: Data? = nil) {
        id = model.id ?? UUID().uuidString
        name = model.name ?? "Unknown User"
        self.imageData = imageData
        description = model.description ?? "No Description"
        website = model.website ?? "https://practicum.yandex.ru/"
        NFTCollectionIDs = model.nfts ?? []
        NFTCount = model.nfts?.count ?? 0
    }
}

enum StatsFilterStrategy: String {
    case NFTCount
    case username
}

@Observable final class StatsViewModel: StatsViewModelProtocol {
    
    var showUserProfileView = false
    var showActionSheet = false
    var isTabBarVisible: Visibility
    
    var filteredUsers: [User] {
        get {
            switch filter {
            case .NFTCount:
                return users.sorted { userLeft, userRight in
                    userLeft.NFTCount > userRight.NFTCount
                }
            case .username:
                return users.sorted { userLeft, userRight in
                    userLeft.name.compare(userRight.name) == .orderedAscending
                }
            }
        }
    }
    
    private(set) var selectedUser: User?
    private(set) var users: [User]
    
    private(set) var isError: Bool = false
    private(set) var isLoading: Bool = false
    
    private let model: StatsModelProtocol
    
    init(showUserProfileView: Bool = false, showActionSheet: Bool = false, isTabBarVisible: Visibility = .visible, selectedUser: User? = nil, users: [User] = [], model: StatsModelProtocol? = nil) {
        self.showUserProfileView = showUserProfileView
        self.showActionSheet = showActionSheet
        self.isTabBarVisible = isTabBarVisible
        self.selectedUser = selectedUser
        self.users = users
        self.model = model ?? StatsModel()
    }
    
    private var filter: StatsFilterStrategy {
        get {
            let storedData = UserDefaults.standard.string(forKey: "statsFilterStrategy")
            
            guard let storedData else {
                return .NFTCount
            }
            
            let filter = StatsFilterStrategy(rawValue: storedData) ?? .NFTCount
            return  filter
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "statsFilterStrategy")
        }
    }
    
    func setFilterStrategy(_ strategy: StatsFilterStrategy) {
        filter = strategy
    }
    
    func selectUser(_ user: User) {
        selectedUser = user
        showUserProfileView = true
    }
    
    func fetchUsers() async {
        isError = false
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            let users = try await model.fetchUserStats()
            
            let usersWithoutAvatars = users.map { User(from: $0) }
            
            self.users = usersWithoutAvatars
            
            for (index, userModel) in users.enumerated() {
                guard let imageURLString = userModel.avatar else { continue }
                self.users[index].isLoadingImage = true
                
//            MARK: было интересно реализовать асинхронную загрузку изображений без использования KingFisher или AsyncImage

                Task.detached(priority: .background) { [weak self] in
                    defer {
                        self?.users[index].isLoadingImage = false
                    }
                    
                    guard let imageData = try? await self?.model.fetchUserImage(urlString: imageURLString) else {
                        return
                    }
                        self?.users[index].imageData = imageData
                    }
                }
        } catch {
            isError = true
            print(error)
        }
    }
    
}

@Observable final class StatsViewModelMock: StatsViewModelProtocol {
    func fetchUsers() async {

    }
    
    var isError: Bool = false
    
    var isLoading: Bool = false
    

    var showActionSheet = false
    var showUserProfileView = false
    var isTabBarVisible: Visibility = .visible
    
    var filteredUsers: [User] {
        get {
            switch filter {
            case .NFTCount:
                return users.sorted { userLeft, userRight in
                    userLeft.NFTCount > userRight.NFTCount
                }
            case .username:
                return users.sorted { userLeft, userRight in
                    userLeft.name.compare(userRight.name) == .orderedAscending
                }
            }
        }
    }
    
    private(set) var selectedUser: User?
    
    private(set) var users: [User] = [
        User(name: "Alex", imageData: nil, NFTCount: 32),
        User(name: "Helen", imageData: nil, description:
                """
                Hi, I'm Helen! And I really like NFTs. I love exploring the world of digital art, discovering unique creators, and collecting pieces that tell a story. For me, NFTs are more than just collectibles — they're a way to support artists and be part of a new creative revolution. I’m always looking for new projects, communities, and ideas that push the boundaries of digital ownership and creativity.
                """,
             NFTCollectionIDs: ["randomID", "anotherRandomID", "lastRandomID"], NFTCount: 21),
        User(name: "Martin",
             imageData: nil,
             NFTCollectionIDs: ["randomID", "anotherRandomID", "lastRandomID"],
             NFTCount: 16),
        User(name: "Olga",
             imageData: nil,
             NFTCount: 132),
//      MARK: данные иконки имитируют реальные изображения
        User(name: "Garry",
             imageData: UIImage(systemName: "person.circle.fill",
                                withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(.uniRed).heicData(),
             NFTCount: 95),
        
        User(name: "Harry",
             imageData: UIImage(systemName: "person.circle.fill",
                                withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(.uniBlue).heicData(),
             NFTCount: 876)
        
    ]
    
    private var filter: StatsFilterStrategy {
        get {
            let storedData = UserDefaults.standard.string(forKey: "statsFilterStrategy")
            
            guard let storedData else {
                return .NFTCount
            }
            
            let filter = StatsFilterStrategy(rawValue: storedData) ?? .NFTCount
            return  filter
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "statsFilterStrategy")
        }
    }
    
    func setFilterStrategy(_ strategy: StatsFilterStrategy) {
        filter = strategy
    }
    
    func selectUser(_ user: User) {
        selectedUser = user
        showUserProfileView = true
    }
}

protocol StatsViewModelProtocol {
    var showActionSheet: Bool { get set }
    var showUserProfileView: Bool { get set }
    var isTabBarVisible: Visibility { get set }

    var selectedUser: User? { get }
    var filteredUsers: [User] { get }
    
    var isError: Bool { get }
    var isLoading: Bool { get }
    
    func setFilterStrategy(_ strategy: StatsFilterStrategy)
    func selectUser(_ user: User)
    func fetchUsers() async
}

