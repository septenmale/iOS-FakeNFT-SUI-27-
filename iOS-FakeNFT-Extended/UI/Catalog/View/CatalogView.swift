import SwiftUI

struct CatalogView: View {
    @State private var selectedSortOption: SortOption = SortSettings.selectedSortOption
    @State private var isShowingSortOptions = false
    @State private var sortedCatalog: [CatalogNft] = []
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        Color.clear
                            .frame(height: 35)
                        
                        ForEach(sortedCatalog, id: \.title) { item in
                            NavigationLink(destination: CollectionView(collection: item)) {
                                CatalogCell(item: item)
                                    .padding(.horizontal, 16)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                
                if isShowingSortOptions {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isShowingSortOptions = false
                            }
                        }
                        .transition(.opacity)
                }
                
                VStack {
                    if isShowingSortOptions {
                        SortPanelView(
                            selectedSortOption: $selectedSortOption,
                            isShowingSortOptions: $isShowingSortOptions
                        )
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        
                        CloseButtonView(isShowingSortOptions: $isShowingSortOptions)
                    }
                }
            }
            .navigationBarHidden(true)
            .overlay(
                sortButton
                    .padding(.top, 2)
                    .padding(.trailing, 9),
                alignment: .topTrailing
            )
            .animation(.easeInOut(duration: 0.3), value: isShowingSortOptions)
            .onAppear {
                applySorting()
            }
            onChange(of: selectedSortOption) { _, _ in
                applySorting()
            }
        }
    }
    
    var sortButton: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                isShowingSortOptions.toggle()
            }
        }) {
            Image("sort")
                .foregroundColor(.yaBlack)
                .frame(width: 42, height: 42)
        }
    }
}

private extension CatalogView {
    
    func applySorting() {
        switch selectedSortOption {
        case .byName:
            sortedCatalog = CatalogSample.catalog.sorted { $0.title < $1.title }
        case .byNFTCount:
            sortedCatalog = CatalogSample.catalog.sorted { $0.currentCount > $1.currentCount }
        }
    }
}

enum SortOption {
    case byName
    case byNFTCount
}

#Preview {
    CatalogView()
}
