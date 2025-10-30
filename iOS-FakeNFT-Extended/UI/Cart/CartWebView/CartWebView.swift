import SwiftUI
import WebKit

struct CartWebView: UIViewRepresentable {
    let url: URL?

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        return WKWebView(frame: .zero, configuration: configuration)
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = url else {return}
        if webView.url != url { 
            webView.load(URLRequest(url: url))
        }
    }
}

//MARK: - Preview
#Preview {
    CartWebView(url: URL(string: CartRequestsConstants.webViewURL))
        .edgesIgnoringSafeArea(.all)
}
