import SwiftUI

struct CollectionCell: View {
    let item: CollectionNFT
    let isLiked: Bool
    let isInCart: Bool
    let onLikeTap: () -> Void
    let onCartTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(Color.yaLightGrey)
                
                if let imageData = item.imageNft,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 108, height: 108)
                        .clipped()
                } else {
                    Image(systemName: "scribble.variable")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                }
                
                Button(action: onLikeTap) {
                    Image("like")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(isLiked ? .uniRed : .uniWhite)
                        .padding(-6)
                        .clipShape(Circle())
                }
                .padding(4)
            }
            .frame(width: 108, height: 108)
            .cornerRadius(12)
            
            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { index in
                    Image("star")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                        .foregroundColor(index < item.rating ? .uniYellow : .yaLightGrey)
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.bold17)
                        .foregroundColor(.yaBlack)
                        .lineLimit(1)
                    
                    Text("\(formattedPrice) ETH")
                        .font(.medium10)
                        .foregroundColor(.yaBlack)
                }
                
                Spacer()
                
                Button(action: onCartTap) {
                    Image(isInCart ? "cartOnExtra" : "cartOffExtra")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.yaBlack)
                }
            }
        }
        .frame(width: 108)
    }
    
    private var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: item.price)) ?? "\(item.price)"
    }
}

#Preview {
    CollectionCell(
        item: CollectionSample.collection[0],
        isLiked: true,
        isInCart: false,
        onLikeTap: {
            print("Like tapped")
        },
        onCartTap: {
            print("Cart tapped")
        }
    )
}
