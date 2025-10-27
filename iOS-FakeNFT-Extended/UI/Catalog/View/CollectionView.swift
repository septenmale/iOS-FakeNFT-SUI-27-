import SwiftUI

struct CollectionView: View {
    let collection: CatalogNft
    @Environment(\.dismiss) private var dismiss
    @State private var likedNft: Set<String> = []
    @State private var cartNft: Set<String> = []
    @State private var showAuthorWebView = false
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(Color.yaLightGrey)
                    
                    Image(collection.catalogImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 310)
                        .clipped()
                        .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Image("backward")
                            .foregroundColor(.yaBlack)
                            .frame(width: 42, height: 42)
                            .clipShape(Circle())
                    }
                    .padding(.leading, 9)
                    .padding(.top, 55)
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(collection.title)
                        .font(.bold22)
                        .foregroundColor(.yaBlack)
                        .padding(.top, 16)
                    
                    HStack {
                        Text("Автор коллекции:")
                            .font(.regular13)
                            .foregroundColor(.yaBlack)
                        
                        NavigationLink(destination: CommonWebView(url: "https://practicum.yandex.ru/")) {
                            Text(collection.author)
                                .font(.regular15)
                                .foregroundColor(.uniBlue)
                        }
                        
                        Spacer()
                    }
                    
                    Text(collection.descriptionNft)
                        .font(.regular13)
                        .foregroundColor(.yaBlack)
                        .lineSpacing(4)
                }
                .padding(.horizontal, 16)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    ForEach(collection.collection, id: \.id) { nft in
                        CollectionCell(
                            item: nft,
                            isLiked: likedNft.contains(nft.id),
                            isInCart: cartNft.contains(nft.id),
                            onLikeTap: {
                                toggleLike(for: nft.id)
                            },
                            onCartTap: {
                                toggleCart(for: nft.id)
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .padding(.bottom, 20)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showAuthorWebView) {
            CommonWebView(url: "https://practicum.yandex.ru/")
        }
    }
    
    private func toggleLike(for id: String) {
        if likedNft.contains(id) {
            likedNft.remove(id)
        } else {
            likedNft.insert(id)
        }
    }
    
    private func toggleCart(for id: String) {
        if cartNft.contains(id) {
            cartNft.remove(id)
        } else {
            cartNft.insert(id)
        }
    }
}

#Preview {
    NavigationView {
        CollectionView(collection: CatalogSample.catalog[0])
    }
}
