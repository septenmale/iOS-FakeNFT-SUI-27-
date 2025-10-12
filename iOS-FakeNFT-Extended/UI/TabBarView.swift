import SwiftUI

struct TabBarView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = .black
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
            
            StatsView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.stats", comment: ""),
                        image: "statistics"
                    )
                }
        }
    }
}
