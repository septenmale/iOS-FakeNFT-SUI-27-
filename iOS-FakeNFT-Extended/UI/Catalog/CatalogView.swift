import SwiftUI

struct CatalogView: View {
    @State private var selectedSortOption: SortOption = .byName
    @State private var isShowingSortOptions = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        Color.clear
                            .frame(height: 35)
                        
                        ForEach(CatalogSample.catalog, id: \.id) { item in
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
        }
    }
    
    private func section(title: String, items: [String]) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.system(size: 50, weight: .semibold))
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.gray.opacity(0.05))
            
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                VStack(spacing: 0) {
                    HStack {
                        Text(item)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    
                    if index < items.count - 1 {
                        Rectangle()
                            .fill(Color.gray.opacity(0.1))
                            .frame(height: 0.5)
                            .padding(.leading, 16)
                    }
                }
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 8)
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

enum SortOption {
    case byName
    case byNFTCount
}

#Preview {
    CatalogView()
}
