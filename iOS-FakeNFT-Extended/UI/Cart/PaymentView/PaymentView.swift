import SwiftUI

struct PaymentView: View {
    @State var viewModel: PaymentViewModel
    @Environment(\.dismiss) private var dismiss
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            currencyList
            Spacer()
        }
        .navigationTitle(String(localized: "Select payment method"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                }
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
        PaymentView(viewModel: viewModel)
    }
}
