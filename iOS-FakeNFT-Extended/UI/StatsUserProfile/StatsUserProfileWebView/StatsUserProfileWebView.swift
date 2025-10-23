//
//  StatsUserProfileWebView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/23/25.
//

import SwiftUI


struct UserProfileWebView: View {
    @Environment(\.dismiss) private var dismiss
    
    let url: String
    
    var body: some View {
        WebView.init(url: URL(string: url))
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
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
    }
}
