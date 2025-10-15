//
//  StatsViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/14/25.
//

import SwiftUI

struct User: Identifiable {
    let id: UUID = UUID()
    let name: String
    let image: Image
    let NFTCount: Int
}

enum StatsFilterStrategy {
    case NFTCount
    case username
}

@Observable class StatsViewModel: StatsViewModelProtocol {
    
    var showUserProfileView = false

    var showActionSheet = false
    
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
    
    private(set) var users: [User] = []
    
    private var filter: StatsFilterStrategy = .NFTCount
    
    func setFilterStrategy(_ strategy: StatsFilterStrategy) {
        filter = strategy
    }
    
    func selectUser(_ user: User) {
        selectedUser = user
        showUserProfileView = true
    }
    
}

@Observable class StatsViewModelMock: StatsViewModelProtocol {

    var showActionSheet = false
    
    var showUserProfileView = false
    
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
        User(name: "Alex", image: Image(systemName: "person.circle.fill"), NFTCount: 32),
        User(name: "Helen", image: Image(systemName: "person.circle.fill"), NFTCount: 21),
        User(name: "Martin", image: Image(systemName: "person.circle.fill"), NFTCount: 16),
        User(name: "Olga", image: Image(systemName: "person.circle.fill"), NFTCount: 132),
        User(name: "Garry", image: Image(systemName: "person.circle.fill"), NFTCount: 95),
        User(name: "Harry", image: Image(systemName: "person.circle.fill"), NFTCount: 876)
    ]
    
    private var filter: StatsFilterStrategy = .NFTCount
    
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
    var selectedUser: User? { get }
    
    var filteredUsers: [User] { get }
    
    func setFilterStrategy(_ strategy: StatsFilterStrategy)
    
    func selectUser(_ user: User)
}

