import SwiftUI

struct TabBarView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = .yaBlack
    }
    
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.profile", comment: ""),
                        image: "profile"
                    )
                }
            
            CatalogView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.catalog", comment: ""),
                        image: "catalog"
                    )
                }
            
            CartView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.cart", comment: ""),
                        image: "basket"
                    )
                }
            
//          MARK: на данный момент используются моковые данные для демонстрации работы
            
            StatsView(viewModel: StatsViewModelMock())
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.stats", comment: ""),
                        image: "statistics"
                    )
                }
        }
    }
}
