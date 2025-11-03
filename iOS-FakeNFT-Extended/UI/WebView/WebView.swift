//
//  WebView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 11/3/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
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
    WebView(url: URL(string: "https://practicum.yandex.ru/"))
        .edgesIgnoringSafeArea(.all)
}
