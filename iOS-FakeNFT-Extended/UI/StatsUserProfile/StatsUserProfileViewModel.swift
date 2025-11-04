import SwiftUI

@Observable class StatsUserProfileViewModel: StatsUserProfileViewModelProtocol {
    var showWebView: Bool = false
    var showUserNFTCollection: Bool = false
}

protocol StatsUserProfileViewModelProtocol {
    var showWebView: Bool { get set }
    var showUserNFTCollection: Bool { get set }
}
