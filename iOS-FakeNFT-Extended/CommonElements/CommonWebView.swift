import SwiftUI

struct CommonWebView: View {
    @Environment(\.dismiss) private var dismiss
    
    let url: String
    
    var body: some View {
        WebView.init(url: URL(string: url))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarBackButtonHidden()
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                    .foregroundStyle(.yaBlack)
                }
            }
            .background(Color.yaWhite)
    }
}
