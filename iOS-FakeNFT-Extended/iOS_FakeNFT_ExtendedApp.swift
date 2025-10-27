import SwiftUI
import SwiftData

@main
struct iOS_FakeNFT_ExtendedApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(ServicesAssembly(networkClient: DefaultNetworkClient(), nftStorage: NftStorageImpl()))
        }
        .modelContainer(for: [InCartNft.self, LikedNft.self], inMemory: true)
    }
}
