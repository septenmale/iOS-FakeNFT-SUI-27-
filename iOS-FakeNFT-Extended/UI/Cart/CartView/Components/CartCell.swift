import SwiftUI

struct CartCell: View {
    
    let item: CartItem
    let onDeleteTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            image
            infoSection
            Spacer()
            deleteIcon
        }
        .padding(16)
        .contentShape(Rectangle())
        .buttonStyle(.plain)
        .background(.yaWhite)
    }
    
    private var image: some View {
        AsyncImage(url: URL(string: item.imageURL)) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: CartSizeConstants.cellImageSize,
                       height: CartSizeConstants.cellImageSize)
                .clipped()
                .cornerRadius(CartSizeConstants.cellImageCornerRadius)
        } placeholder: {
            ProgressView()
        }
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(item.name)
                .font(.bold17)
                .padding(.bottom, 6)
            
            HStack(spacing: 2) {
                ForEach(0..<5) { index in
                    Image("star")
                        .renderingMode(.template)
                        .foregroundColor(index < item.rating ? .yellow : .yaLightGrey)
                }
            }
            .padding(.bottom, 14)
            
            Text(String(localized: "Price"))
                .font(.regular13)
                .padding(.bottom, 4)
            
            Text("\(item.price, specifier: "%.2f") ETH")
                .font(.bold17)
        }
        .foregroundColor(.yaBlack)
    }
    
    private var deleteIcon: some View {
        Button(action: onDeleteTapped) {
            Image("cartOnExtra")
                .foregroundColor(.yaBlack)
        }
        .buttonStyle(.plain)
    }
}
