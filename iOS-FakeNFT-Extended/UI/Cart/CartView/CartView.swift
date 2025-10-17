import SwiftUI

struct CartView: View {
    
    @State private var viewModel = CartViewModel()
    @State private var showDeleteConfirmation = false
    @State private var showPayment = false
    @State private var itemToDelete: CartItem?
    
    @State var hideTabBar = false
    
    var body: some View {
        ZStack {
            if viewModel.items.isEmpty {
                EmptyCartView()
            } else {
                VStack(spacing: 0) {
                    nftList
                    totalSection
                }
            }
            
            if showDeleteConfirmation, let item = itemToDelete {
                DeleteConfirmationView(
                    item: item,
                    onConfirm: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showDeleteConfirmation = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            viewModel.removeItem(item)
                        }
                        itemToDelete = nil
                    },
                    onCancel: {
                        showDeleteConfirmation = false
                        itemToDelete = nil
                    }
                )
            }
        }
        .toolbar(showDeleteConfirmation ? .hidden : .visible, for: .tabBar)
        .animation(.easeInOut(duration: 0.2), value: viewModel.items.count)
    }
    
    private var nftList: some View {
        List {
            ForEach(viewModel.items) { nft in
                CartCell(item: nft){
                    itemToDelete = nft
                    showDeleteConfirmation = true
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.plain)
        .padding(.top, 20)
    }
    
    private var totalSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("\(viewModel.items.count) NFT")
                    .font(.regular15)
                    .foregroundColor(.uniBackground)
                
                Text("\(viewModel.totalPrice, specifier: "%.2f") ETH")
                    .font(.bold17)
                    .foregroundColor(.green)
            }
            Spacer()
            Button {
                showPayment = true
            }
            label: {
                Text(String(localized: "To payment"))
                    .font(.bold17)
                    .foregroundColor(.yaWhite)
                    .frame(width: CartSizeConstants.paymentButtonWidth, height: CartSizeConstants.paymentButtonHeight)
                    .background(.yaBlack)
                    .cornerRadius(CartSizeConstants.buttonRadius)
            }
            .fullScreenCover(isPresented: $showPayment) {
                NavigationStack {
                    let paymentVM = PaymentViewModel(cartItems: viewModel.items)
                    PaymentView(viewModel: paymentVM)
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: CartSizeConstants.totalSectionHeight)
        .background(.yaLightGrey)
        .cornerRadius(CartSizeConstants.totalSectionRadius, corners: [.topLeft, .topRight])
    }
}

#Preview {
    CartView()
}
