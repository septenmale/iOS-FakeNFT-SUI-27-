import SwiftUI

struct EmptyCartView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Cart is empty")
                .font(.bold17)
                .foregroundColor(.yaBlack)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.yaWhite)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    EmptyCartView()
}
