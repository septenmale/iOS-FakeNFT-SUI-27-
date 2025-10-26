import SwiftUI

struct SuccessPaymentView: View {
    let onReturn: () -> Void

    var body: some View {
        VStack {
            Spacer()
            image
            title
            Spacer()
            button
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    private var image: some View {
        Image("successPaymentImage")
            .resizable()
            .scaledToFit()
            .frame(
                width: CartSizeConstants.successImageSize,
                height: CartSizeConstants.successImageSize
            )
            .padding(.bottom, 20)
    }
    
    private var title: some View {
        Text(String(localized: "Success! Payment completed, congratulations on your purchase!"))
            .font(.bold22)
            .foregroundColor(.yaBlack)
            .padding(.horizontal, 36)
            .multilineTextAlignment(.center)
    }
    
    private var button: some View {
        Button(String(localized: "Return to cart")) {
            onReturn()
        }
        .font(.bold17)
        .foregroundColor(.yaWhite)
        .frame(maxWidth: .infinity)
        .frame(height: CartSizeConstants.successButtonHeight)
        .background(.yaBlack)
        .cornerRadius(CartSizeConstants.successButtonRadius)
        .padding(16)
    }
}

#Preview {
    SuccessPaymentView(onReturn:{})
}

