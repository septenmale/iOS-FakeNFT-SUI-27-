//
//  CommonProgressView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/27/25.
//

import SwiftUI

struct CommonProgressView: View {
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.progressViewColorGrey)
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.uniTrueBlack)
                .opacity(scheme == .dark ? 0.2 : 0)
            ProgressView()
                .tint(.uniTrueBlack)
                .scaleEffect(2)
        }
        .frame(width: 82, height: 82)
    }
}
