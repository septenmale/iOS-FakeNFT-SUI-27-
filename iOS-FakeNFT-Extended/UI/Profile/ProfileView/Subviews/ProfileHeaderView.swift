//
//  ProfileHeaderView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Viktor Zavhorodnii on 13/10/2025.
//

import SwiftUI

struct ProfileHeaderView: View {
    let imageURL: String
    let name: String
    let bio: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 16) {
                //TODO: Переделать на url
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                Text("\(name)")
                    .font(.system(size: 22, weight: .bold))
            }
            Text("\(bio)")
                .font(.system(size: 13, weight: .regular))
            Link("Joaquin Phoenix.com", destination: URL(string: "https://practicum.yandex.kz/ios-developer")!)
                .font(.system(size: 15, weight: .regular))
                .padding(.top, -12)
        }
    }
}
