import SwiftUI

struct CartCell: View {
    
    private enum SizeConstants {
        static let imageSize: CGFloat = 108
        static let imageCornerRadius: CGFloat = 12
    }
    
    let item: CartItem
    
    var body: some View {
        HStack(spacing: 20) {
            image
            infoSection
            Spacer()
            deleteIcon
        }
    }
    
    private var image: some View {
        Image(item.name)
            .resizable()
            .scaledToFill()
            .frame(width: SizeConstants.imageSize, height: SizeConstants.imageSize)
            .clipped()
            .cornerRadius(SizeConstants.imageCornerRadius)
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(item.name)
                .font(Font(UIFont.bold17))
                .padding(.bottom, 6)
            
            HStack(spacing: 2) {
                ForEach(0..<5) { index in
                    Image("star")
                        .renderingMode(.template)
                        .foregroundColor(index < item.rating ? .yellow : Color(UIColor.segmentInactive))
                }
            }
            .padding(.bottom, 14)
            
            Text(String(localized: "Price"))
                .font(Font(UIFont.regular13))
                .padding(.bottom, 4)
            
            Text("\(item.price, specifier: "%.2f") ETH")
                .font(Font(UIFont.bold17))
        }
        .foregroundColor(Color(UIColor.segmentActive))//TODO: по тз
    }
    
    private var deleteIcon: some View {
        Image("cartOn")
            .foregroundColor(Color(UIColor.segmentActive))
    }
}

#Preview {
    CartCell(item: MockItems.items[0])
}
