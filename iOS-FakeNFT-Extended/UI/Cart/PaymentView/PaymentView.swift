import SwiftUI

struct PaymentView: View {
    @State var viewModel: PaymentViewModel
    @State private var showPaymentErrorAlert = false
    var onSuccess: () -> Void
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            currencyList
            Spacer()
            payBlock
        }
        .navigationTitle(String(localized: "Select payment method"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CartBackButton(color: .yaBlack)
            }
        }
        .alert(
            String(localized: "Payment failed"),
            isPresented: $showPaymentErrorAlert
        ) {
            Button(String(localized: "Cancel"), role: .cancel) {}
            Button(String(localized: "Repeat")) {
                pay()
            }
        }
    }
    
    private var currencyList: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 7) {
                ForEach(viewModel.currencies) { currency in
                    CurrencyCell(
                        currency: currency,
                        isSelected: viewModel.selectedCurrencyId == currency.id
                    )
                    .onTapGesture {viewModel.selectCurrency(currency)}
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
        }
    }
    
    private var payBlock: some View {
        VStack(alignment: .leading, spacing: 16) {
            userAgreementSegment
            payButton
        }
        .padding(16)
        .background(
            Color.yaLightGrey
                .cornerRadius(CartSizeConstants.payBlockRadius, corners: [.topLeft, .topRight])
                .ignoresSafeArea()
        )
    }
    
    private var userAgreementSegment: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(String(localized: "By making a purchase, you agree to the terms of the"))
                .font(.regular13)
                .foregroundColor(.yaBlack)
            
            NavigationLink {
                WebView(url: URL(string: CartRequestConstants.webViewURL))
                    .navigationTitle(String(localized: "User agreement:"))
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(true)
                    .toolbar(.hidden, for: .tabBar)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            CartBackButton(color: .yaBlack)
                        }
                    }
                    .ignoresSafeArea()
            } label: {
                Text(String(localized: "User agreement"))
                    .font(.regular13)
                    .foregroundColor(.uniBlue)
            }
        }
    }
    
    private var payButton: some View {
        let isDisabled = viewModel.selectedCurrencyId.isEmpty
        
        return Button(action: {
           pay()
        }) {
            Text(String(localized: "Pay"))
                .font(.bold17)
                .foregroundColor(.yaWhite)
                .frame(maxWidth: .infinity)
                .frame(height: CartSizeConstants.payButtonHeight)
                .background(.yaBlack)
                .cornerRadius(CartSizeConstants.payButtonRadius)
                .opacity(isDisabled ? 0.6 : 1)
        }
        .disabled(isDisabled)
    }
    
    func pay() {
        Task {
            let successPayment = await viewModel.payOrder()
            if successPayment {
                onSuccess()
            } else {
                showPaymentErrorAlert = true
            }
        }
    }
}

#Preview {
    let mockCurrencies = [
        Currency(id: "1", title: "Bitcoin", name: "ВТС", image: "https://"),
        Currency(id: "2", title: "Dogecoin", name: "DOGE", image: "https://"),
        Currency(id: "3", title: "Tether", name: "USDT", image: "https://"),
        Currency(id: "4", title: "Apecoin", name: "APE", image: "https://")
    ]
    
    let mockItems = [
        CartItem(imageURL: "", name: "April", rating: 4, price: 1.78),
        CartItem(imageURL: "", name: "Greena", rating: 5, price: 3.08)
    ]
    
    let viewModel = PaymentViewModel(cartItems: mockItems)
    
    NavigationStack {
        PaymentView(viewModel: viewModel, onSuccess: {})
    }
}

