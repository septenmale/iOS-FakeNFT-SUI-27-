//
//  UserNFTCollectionView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/23/25.
//

import SwiftUI
import SwiftData

struct UserNFTCollectionView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Query private var likedNFTs: [LikedNft]
    @Query private var inCartNFTs: [InCartNft]
        
    @State private var viewModel: UserNFTCollectionViewModelProtocol
    
    private let gridColumns = Array(repeating: GridItem(), count: 3)
    
    private let navigationTitleFont: Font = .bold17
    
    init(userCollection: [String], viewModel: UserNFTCollectionViewModelProtocol? = nil) {
        self.viewModel = viewModel ?? UserNFTCollectionViewModel(userCollectionIds: userCollection)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 8) {
                    ForEach(viewModel.fetchedElements, id: \.id) { element in
                        let isLiked = likedNFTs.contains { $0.id == element.id }
                        let isInCart = inCartNFTs.contains {$0.id == element.id }
                        
                        UserCollectionNFTCell(element: element, isLiked: isLiked, isInCart: isInCart, likeButtonAction: { cellLikeButtonAction(id: element.id) }, cartButtonAction: { cellCartButtonAction(id: element.id) })
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
            .disabled(viewModel.isLoading)
            
            CommonProgressView()
                .opacity(viewModel.isLoading ? 1 : 0)
        }
        .onAppear {
            viewModel.insertModelContext(context: context)
        }
        .task {
            await viewModel.fetchUserCollection()
        }
        .background(Color.yaWhite)
        .navigationBarBackButtonHidden()
        .navigationTitle("Коллекция NFT")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .foregroundStyle(.yaBlack)
            }
        }
    }
    
    func cellLikeButtonAction(id: String) {
        viewModel.toggleLikeNFT(id: id, likedNFTs: likedNFTs)
    }
    
    func cellCartButtonAction(id: String) {
        viewModel.toggleAddNFTToCart(id: id, inCartNFTs: inCartNFTs)
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    
    NavigationStack {
        Button("Open UserNFTCollection") {
            isPresented = true
        }
        .navigationDestination(isPresented: $isPresented) {
            UserNFTCollectionView(userCollection: ["randomID", "anotherRandomID", "lastRandomID"])
        }
    }
}
