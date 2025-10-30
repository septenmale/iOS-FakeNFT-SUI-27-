import SwiftUI
import SwiftData

struct CartView: View {
    @Environment(\.modelContext) private var context
    
    @State private var viewModel: CartViewModel?
    @State private var itemToDelete: CartItem?
    @State private var path: [CartNavigationDestination] = []
    @State private var showDeleteConfirmation = false
    @State private var showSortDialog = false
    
    @State var hideTabBar = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                if let viewModel = viewModel {
                    if viewModel.isLoading {
                        VStack {
                            ProgressView("Loading NFTs...")
                        }
                    } else if viewModel.items.isEmpty {
                        EmptyCartView()
                    } else {
                        VStack(spacing: 0) {
                            nftList(viewModel: viewModel)
                            totalSection(viewModel: viewModel)
                        }
                    }
                } else {
                    ProgressView()
                }
                if showDeleteConfirmation, let item = itemToDelete {
                    DeleteConfirmationView(
                        item: item,
                        onConfirm: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showDeleteConfirmation = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                viewModel?.removeItem(item)
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
            .task {
                if viewModel == nil {
                    viewModel = CartViewModel(context: context)
                    await viewModel?.loadCart()
                }
            }
            .navigationDestination(for: CartNavigationDestination.self) { destination in
                switch destination {
                case .payment(let cartItems):
                    PaymentView(
                        viewModel: PaymentViewModel(cartItemsId: cartItems.map(\.id)),
                        onSuccess: {
                            path.append(.success)
                        })
                case .success:
                    SuccessPaymentView {
                        viewModel?.clearCart()
                        path.removeLast(path.count)
                    }
                }
            }
            .toolbar(showDeleteConfirmation ? .hidden : .visible, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSortDialog = true
                    } label: {
                        Image("sort")
                            .foregroundColor(.yaBlack)
                    }
                }
            }
            .confirmationDialog(
                String(localized: "Sorting"),
                isPresented: $showSortDialog,
                titleVisibility: .visible
            ) {
                ForEach(CartSortType.allCases) { type in
                    Button(LocalizedStringKey(type.rawValue)) {
                        viewModel?.selectSort(type)
                        showSortDialog = false
                    }
                }
                Button(String(localized: "Close"), role: .cancel) {}
            }
            .animation(.easeInOut(duration: 0.2), value: viewModel?.items.count)
        }
    }
    
    private func nftList(viewModel: CartViewModel) -> some View {
        List {
            ForEach(viewModel.items) { nft in
                CartCell(item: nft) {
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
    
    private func totalSection(viewModel: CartViewModel) -> some View {
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
                path.append(.payment(cartItems: viewModel.items))
            } label: {
                Text(String(localized: "To payment"))
                    .font(.bold17)
                    .foregroundColor(.yaWhite)
                    .frame(width: CartSizeConstants.paymentButtonWidth, height: CartSizeConstants.paymentButtonHeight)
                    .background(.yaBlack)
                    .cornerRadius(CartSizeConstants.buttonRadius)
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


