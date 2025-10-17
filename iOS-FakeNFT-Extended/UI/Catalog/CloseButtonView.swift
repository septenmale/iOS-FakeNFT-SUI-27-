import SwiftUI

struct CloseButtonView: View {
    @Binding var isShowingSortOptions: Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                isShowingSortOptions = false
            }
        }) {
            Text("Закрыть")
            //TODO: добавить bold20
                .font(.bold22)
                .foregroundColor(.uniBlue)
                .frame(maxWidth: .infinity)
                .frame(height: 61)
                .background(.yaWhite)
                .cornerRadius(13)
                .padding(.horizontal, 8)
                .padding(.bottom, 32)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    @State var isShowing = true
    
    return ZStack {
        Color.black.opacity(0.3).ignoresSafeArea()
        
        VStack {
            Spacer()
            CloseButtonView(isShowingSortOptions: $isShowing)
        }
    }
}
