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
            if viewModel.isLoading {
                Spacer()
                CommonProgressView()
            } else {
                currencyList
            }
            Spacer()
            payBlock
        }
        .background(.yaWhite)
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
            Button("Cancel", role: .cancel) {}
            Button("Repeat") {
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
                    .background(.yaWhite)
                    .toolbar(.hidden, for: .tabBar)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            CartBackButton(color: .yaBlack)
                        }
                    }
                    .ignoresSafeArea(edges: .bottom)
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
