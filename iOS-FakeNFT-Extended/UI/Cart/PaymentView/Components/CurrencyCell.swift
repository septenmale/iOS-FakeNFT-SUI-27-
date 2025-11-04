import SwiftUI

struct CurrencyCell: View {
    let currency: Currency
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            image
            text
            Spacer()
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 12)
        .background(.yaLightGrey)
        .cornerRadius(CartSizeConstants.cellImageCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? .yaBlack : .clear, lineWidth: 1)
        )
    }
    
    private var image: some View {
        AsyncImage(url: URL(string: currency.image)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
                .tint(.gray)
        }
        .frame(width: CartSizeConstants.currencyImageSize, height: CartSizeConstants.currencyImageSize)
        .clipped()
        .cornerRadius(CartSizeConstants.currencyImageCornerRadius)
    }
    
    private var text: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(currency.title)
                .font(.regular13)
                .foregroundColor(.yaBlack)
            Text(currency.name)
                .font(.regular13)
                .foregroundColor(.uniGreen)
        }
    }
}
