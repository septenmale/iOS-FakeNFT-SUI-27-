//
//  CollectionNFTCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/23/25.
//

import SwiftUI
import SwiftData

struct UserCollectionNFTCell: View {
    
    let element: UserCollectionNFTItem
    let isLiked: Bool
    let isInCart: Bool
    
    var likeButtonAction: (() -> Void)?
    var cartButtonAction: (() -> Void)?
    
    init(element: UserCollectionNFTItem, isLiked: Bool? = nil, isInCart: Bool? = nil, likeButtonAction: (() -> Void)? = nil, cartButtonAction: (() -> Void)? = nil) {
        self.element = element
        self.isLiked = isLiked ?? false
        self.isInCart = isInCart ?? false
        self.likeButtonAction = likeButtonAction
        self.cartButtonAction = cartButtonAction
    }
    
    var body: some View {
        VStack(spacing: 8) {
            imageWithLikeButton
            starsRating
            elementInfo
        }
        .padding(.bottom, 20)
        .frame(width: 108)
    }
    
    private var imageWithLikeButton: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: element.imageUrl) { phase in
                Group {
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Image(systemName: "person.slash")
                            .resizable()
                            .scaledToFill()
                    }
                    else {
                        ProgressView()
                    }
                }
                .background(Color.yaLightGrey)
                .frame(height: 108)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Button(action: {
                likeButtonAction?()
            }) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(isLiked ? .uniRed : .uniWhite)
                    .padding(.vertical, 12)
            }
            .frame(width: 40, height: 40)
        }
    }
    
    private var starsRating: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { star in
                let rating = element.rating
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(rating >= star ? .uniYellow : .yaLightGrey)
            }
            Spacer()
        }
    }
    
    private var elementInfo: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text(element.name)
                    .font(.bold17)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.yaBlack)
                
                Text("\(element.price.formatted()) ETH")
                    .font(.medium10)
                    .foregroundColor(.yaBlack)
            }
            
            Spacer(minLength: 0)

            Button {
                cartButtonAction?()
            } label: {
                Image(isInCart ? "cartOnExtra" : "cartOffExtra")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 12)
                    .foregroundColor(.yaBlack)
            }
            .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    @Previewable @State var isLiked: Bool = false
    @Previewable @State var isInCart: Bool = false
    
    VStack {
        UserCollectionNFTCell(element: UserCollectionNFTItem(id: "aloha", name: "a", rating: 2, price: 1.201), isLiked: isLiked, isInCart: isInCart,
        likeButtonAction: {
            isLiked.toggle()
        },
        cartButtonAction: {
            isInCart.toggle()
        })
    }
}
