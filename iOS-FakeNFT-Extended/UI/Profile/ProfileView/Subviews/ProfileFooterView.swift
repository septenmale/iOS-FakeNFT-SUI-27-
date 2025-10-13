//
//  ProfileFooterView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Viktor Zavhorodnii on 13/10/2025.
//

import SwiftUI

struct ProfileFooterView: View {
    let nftCount: Int
    let favouritesCount: Int
    
    var body: some View {
        VStack(spacing: 16) {
            NavigationLink(destination: StatsView()) {
                HStack {
                    HStack(spacing: 8) {
                        Text("Мои NFT")
                        Text("(\(nftCount))")
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            NavigationLink(destination: CatalogView()) {
                HStack {
                    HStack(spacing: 8) {
                        Text("Избранные NFT")
                        Text("(\(favouritesCount))")
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
        }
        .font(.system(size: 17, weight: .bold))
        .foregroundColor(.primary)
    }
}
