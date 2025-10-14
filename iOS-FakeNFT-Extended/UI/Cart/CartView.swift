import SwiftUI

struct CartView: View {
    @State private var viewModel = CartViewModel()
    
    var body: some View {
        VStack {
            nftList
            priceSection
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
}

private var priceSection: some View {
    EmptyView()
}

#Preview {
    CartView()
}

