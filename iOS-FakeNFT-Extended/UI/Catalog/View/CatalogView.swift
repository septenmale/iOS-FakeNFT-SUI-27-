import SwiftUI

struct CatalogView: View {
    @State private var selectedSortOption: SortOption = SortSettings.selectedSortOption
    @State private var isShowingSortOptions = false
    @State private var sortedCatalog: [CatalogNft] = []
    @State private var isLoading = false
    @State private var coverImages: [String: UIImage] = [:]
    
    @Environment(ServicesAssembly.self) private var servicesAssembly
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                if isLoading {
                    ProgressView("Загрузка коллекций...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            Color.clear
                                .frame(height: 35)
                            
                            ForEach(sortedCatalog, id: \.title) { item in
                                NavigationLink(
                                    destination: CollectionView(
                                        collection: item,
                                        coverImage: coverImages[item.catalogImage]
                                    )
                                ) {
                                    CatalogCell(
                                        item: item,
                                        coverImage: coverImages[item.catalogImage]
                                    )
                                    .padding(.horizontal, 16)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
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
                loadCatalogData()
            }
            .onChange(of: selectedSortOption) { _, _ in
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
        .disabled(isLoading)
    }
}

private extension CatalogView {
    
    func loadCatalogData() {
        Task {
            isLoading = true
            do {
                let catalogData = try await servicesAssembly.dataConversionService.loadCatalogData()
                await MainActor.run {
                    self.sortedCatalog = catalogData
                    self.applySorting()
                    self.isLoading = false
                    self.preloadCoverImages()
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.sortedCatalog = []
                }
            }
        }
    }
    
    func applySorting() {
        switch selectedSortOption {
        case .byName:
            sortedCatalog = sortedCatalog.sorted { $0.title < $1.title }
        case .byNFTCount:
            sortedCatalog = sortedCatalog.sorted { $0.currentCount > $1.currentCount }
        }
    }
    
    private func preloadCoverImages() {
        for catalogItem in sortedCatalog {
            loadCoverImage(for: catalogItem.catalogImage)
        }
    }
    
    private func loadCoverImage(for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    await MainActor.run {
                        self.coverImages[urlString] = image
                    }
                }
            } catch {
                print("Error loading cover image: \(error)")
            }
        }
    }
}

enum SortOption {
    case byName
    case byNFTCount
}

#Preview {
    CatalogView()
        .environment(
            ServicesAssembly(
                networkClient: DefaultNetworkClient(),
                nftStorage: NftStorageImpl()
            )
        )
}
