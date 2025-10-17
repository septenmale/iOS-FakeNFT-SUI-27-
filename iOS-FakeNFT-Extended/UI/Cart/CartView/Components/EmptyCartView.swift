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
    }
}

#Preview {
    EmptyCartView()
}