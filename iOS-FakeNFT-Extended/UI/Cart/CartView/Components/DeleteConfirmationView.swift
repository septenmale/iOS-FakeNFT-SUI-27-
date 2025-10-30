import SwiftUI

struct DeleteConfirmationView: View {
   
    let item: CartItem
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                AsyncImage(url: URL(string: item.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: CartSizeConstants.modalImageSize, height: CartSizeConstants.modalImageSize)
                        .cornerRadius(CartSizeConstants.modalImageRadius)
                } placeholder: {
                    ProgressView()
                }
                
                VStack(spacing: 0) {
                    Text(String(localized:"Are you sure you want to"))
                    Text(String(localized:"remove this item from your cart?"))
                }
                .font(.regular13)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
                
                HStack(spacing: 8) {
                    CartModalButton(String(localized: "Remove"), foreground: .uniRed, action: onConfirm)
                    CartModalButton(String(localized: "Return"), foreground: .yaWhite, action: onCancel)
                }
            }
            .padding(.horizontal, 35)
        }
    }
}
