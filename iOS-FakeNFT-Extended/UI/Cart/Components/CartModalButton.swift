import SwiftUI

struct CartModalButton: View {
    
    let title: String
    let foreground: Color
    let action: () -> Void

    init(
        _ title: String,
        foreground: Color = .white,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.foreground = foreground
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.regular17)
                .frame(height: CartSizeConstants.modalButtonHeight)
                .frame(maxWidth: .infinity)
                .background(.yaBlack)
                .foregroundColor(foreground)
                .cornerRadius(CartSizeConstants.modalButtonRadius)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack(spacing: 8) {
        CartModalButton(String(localized: "Remove"), foreground: .uniRed) {
            print("Remove tapped")
        }
        CartModalButton(String(localized: "Return"), foreground: .yaWhite) {
            print("Cancel tapped")
        }
    }
    .padding(.horizontal, 35)
}
