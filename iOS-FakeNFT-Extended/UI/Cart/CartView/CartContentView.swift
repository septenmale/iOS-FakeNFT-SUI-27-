//import SwiftUI
//
//struct CartContentView: View {
//    @State var viewModel: CartViewModel
//    @State private var showDeleteConfirmation = false
//    @State private var showSortDialog = false
//    @State private var itemToDelete: CartItem?
//    @State private var path: [CartNavigationDestination] = []
//
//    var body: some View {
//        NavigationStack(path: $path) {
//            ZStack {
//                switch viewModel.loadingState {
//                case .loading, .initial: 
//                    ProgressView()
//                case .success:
//                    if viewModel.items.isEmpty {
//                        EmptyCartView()
//                    } else {
//                        VStack(spacing: 0) {
//                            nftList
//                            totalSection
//                        }
//                    }
//                case .failure:
//                    errorCartView
//                }
//                
//                if showDeleteConfirmation, let item = itemToDelete {
//                    DeleteConfirmationView(
//                        item: item,
//                        onConfirm: {
//                            withAnimation(.easeInOut(duration: 0.2)) {
//                                showDeleteConfirmation = false
//                            }
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//                                viewModel.removeItem(item)
//                            }
//                            itemToDelete = nil
//                        },
//                        onCancel: {
//                            showDeleteConfirmation = false
//                            itemToDelete = nil
//                        }
//                    )
//                }
//            }
//            .navigationDestination(for: CartNavigationDestination.self) { destination in
//                switch destination {
//                case .payment(let cartItems):
//                    PaymentView(
//                        viewModel: PaymentViewModel(cartItems: cartItems),
//                        onSuccess: {
//                            path.append(.success)
//                        })
//                case .success:
//                    SuccessPaymentView {
//                        viewModel.clearCart()
//                        path.removeAll()
//                    }
//                }
//            }
//            .toolbar(showDeleteConfirmation ? .hidden : .visible, for: .tabBar)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        showSortDialog = true
//                    } label: {
//                        Image("sort")
//                            .foregroundColor(.yaBlack)
//                    }
//                }
//            }
//            .confirmationDialog(
//                String(localized: "Sorting"),
//                isPresented: $showSortDialog,
//                titleVisibility: .visible
//            ) {
//                ForEach(CartSortType.allCases) { type in
//                    Button(LocalizedStringKey(type.rawValue)) {
//                        viewModel.selectSort(type)
//                        showSortDialog = false
//                    }
//                }
//
//                Button(String(localized: "Close"), role: .cancel) {}
//            }
//            .animation(.easeInOut(duration: 0.2), value: viewModel.items.count)
//        }
//    }
//
//    // MARK: - Components
//
//    private var nftList: some View {
//        List {
//            ForEach(viewModel.items) { nft in
//                CartCell(item: nft) {
//                    itemToDelete = nft
//                    showDeleteConfirmation = true
//                }
//                .listRowSeparator(.hidden)
//                .listRowInsets(EdgeInsets())
//            }
//        }
//        .listStyle(.plain)
//        .padding(.top, 20)
//    }
//
//    private var totalSection: some View {
//        HStack {
//            VStack(alignment: .leading, spacing: 2) {
//                Text("\(viewModel.items.count) NFT")
//                    .font(.regular15)
//                    .foregroundColor(.uniBackground)
//
//                Text("\(viewModel.totalPrice, specifier: "%.2f") ETH")
//                    .font(.bold17)
//                    .foregroundColor(.green)
//            }
//            Spacer()
//            Button {
//                path.append(.payment(cartItems: viewModel.items))
//            } label: {
//                Text(String(localized: "To payment"))
//                    .font(.bold17)
//                    .foregroundColor(.yaWhite)
//                    .frame(width: CartSizeConstants.paymentButtonWidth, height: CartSizeConstants.paymentButtonHeight)
//                    .background(.yaBlack)
//                    .cornerRadius(CartSizeConstants.buttonRadius)
//            }
//        }
//        .padding(.horizontal, 16)
//        .frame(height: CartSizeConstants.totalSectionHeight)
//        .background(.yaLightGrey)
//        .cornerRadius(CartSizeConstants.totalSectionRadius, corners: [.topLeft, .topRight])
//    }
//    
//    private var errorCartView: some View {
//        VStack {
//            Spacer()
//            Text(String(localized: "Error"))
//                .font(.bold17)
//                .foregroundColor(.yaBlack)
//            Spacer()
//        }
//    }
//}
