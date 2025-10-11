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
                .backgroundStyle(.background)
            
            CatalogView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.catalog", comment: ""),
                        image: "catalog"
                    )
                }
                .backgroundStyle(.background)
                .foregroundStyle(.black)
            
            CartView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.cart", comment: ""),
                        image: "basket"
                    )
                }
                .backgroundStyle(.background)
            
            StatsView()
                .tabItem {
                    Label(
                        NSLocalizedString("Tab.stats", comment: ""),
                        image: "statistics"
                    )
                }
                .backgroundStyle(.background)
        }
    }
}
