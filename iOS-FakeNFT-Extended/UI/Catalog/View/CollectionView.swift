import SwiftUI
import SwiftData

struct CollectionView: View {
    let collection: CatalogNft
    let coverImage: UIImage?
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var likedNfts: [LikedNft]
    @Query private var cartNfts: [InCartNft]
    @State private var showAuthorWebView = false
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(Color.yaLightGrey)
                    
                    if let coverImage = coverImage {
                        Image(uiImage: coverImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 310)
                            .clipped()
                    } else {
                        AsyncImage(url: URL(string: collection.catalogImage)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 310)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 310)
                                    .clipped()
                            case .failure:
                                Rectangle()
                                    .fill(Color.yaLightGrey)
                                    .frame(height: 310)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    
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
                        
                        Button(action: {
                            showAuthorWebView = true
                        }) {
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
                            isLiked: likedNfts.contains { $0.id == nft.id },
                            isInCart: cartNfts.contains { $0.id == nft.id },
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
        .background(Color.yaWhite)
    }
    
    private func toggleLike(for id: String) {
        if let existingLike = likedNfts.first(where: { $0.id == id }) {
            modelContext.delete(existingLike)
        } else {
            let newLike = LikedNft(id: id)
            modelContext.insert(newLike)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving like: \(error)")
        }
    }
    
    private func toggleCart(for id: String) {
        if let existingCartItem = cartNfts.first(where: { $0.id == id }) {
            modelContext.delete(existingCartItem)
            print("Removed NFT \(id) from cart")
        } else {
            let newCartItem = InCartNft(id: id)
            modelContext.insert(newCartItem)
            print("Added NFT \(id) to cart")
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving cart: \(error)")
        }
    }
}

#Preview {
    NavigationView {
        CollectionView(
            collection: CatalogSample.catalog[0],
            coverImage: UIImage(named: "fireworks")
        )
    }
}
