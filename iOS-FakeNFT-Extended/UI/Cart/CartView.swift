import SwiftUI

struct CartView: View {
    @State private var viewModel = CartViewModel()
    
    private enum SizeConstants {
        static let buttonWidth: CGFloat = 240
        static let buttonHeight: CGFloat = 44
        static let buttonRadius: CGFloat = 16
        static let totalSectionHeight: CGFloat = 76
        static let totalSectionRadius: CGFloat = 20
    }
    
    var body: some View {
        if viewModel.items.isEmpty {
            emptyCartView
        } else {
            VStack {
                nftList
                totalSection
            }
        }
    }
    
    private var nftList: some View {
        List {
            ForEach(viewModel.items) { nft in
                CartCell(item: nft)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(16)
            }
        }
        .listStyle(PlainListStyle())
        .padding(.top, 20)
    }
    
    private var emptyCartView: some View {
        VStack {
            Spacer()
            Text(String(localized: "Cart is empty"))
                .font(.bold17)
                .foregroundColor(.black) //TODO: ЗАМЕНИТЬ ЦВЕТ
            Spacer()
        }
    }
    
    private var totalSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("\(viewModel.items.count) NFT")
                    .font(.regular15)
                    .foregroundColor(Color(UIColor.segmentActive))
                
                Text("\(viewModel.totalPrice, specifier: "%.2f") ETH")
                    .font(.bold17)
                    .foregroundColor(.green)
            }
            Spacer()
            Button {}
            label: {
                Text(String(localized: "To payment"))
                    .font(.bold17)
                    .foregroundColor(.white) //TODO: ЗАМЕНИТЬ ЦВЕТ
                    .frame(width: SizeConstants.buttonWidth, height: SizeConstants.buttonHeight)
                    .background(.black) //TODO: ЗАМЕНИТЬ ЦВЕТ
                    .cornerRadius(SizeConstants.buttonRadius)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: SizeConstants.totalSectionHeight)
        .background(Color(UIColor.segmentInactive))
        .cornerRadius(SizeConstants.totalSectionRadius, corners: [.topLeft, .topRight])
    }
}

#Preview {
   CartView()
}

