//
//  ProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/11/25.
//

import SwiftUI

struct ProfileView: View {
    //TODO: Данные перемененные позже перенести во VM
    @State private var imageURL = ""
    @State private var profileName = "Joaquin Phoenix"
    @State private var profileBio = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
    @State private var nftCount = 112
    @State private var favouritesCount = 11
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                ProfileHeaderView(imageURL: imageURL,
                                  name: profileName,
                                  bio: profileBio)
                ProfileFooterView(nftCount: nftCount,
                                  favouritesCount: favouritesCount)
                Spacer()
            }
            .padding()
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        print("Edit button tapped!")
                    }) {
                        Image(.edit)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
