//
//  StatsUserProfileViewModel.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/22/25.
//

import SwiftUI

@Observable class StatsUserProfileViewModel: StatsUserProfileViewModelProtocol {
    let user: User
    
    var showWebView: Bool = false
    var showUserNFTCollection: Bool = false

    init(user: User) {
        self.user = user
    }
}

protocol StatsUserProfileViewModelProtocol {
    var user: User { get }
    
    var showWebView: Bool { get set }
    var showUserNFTCollection: Bool { get set }
}
