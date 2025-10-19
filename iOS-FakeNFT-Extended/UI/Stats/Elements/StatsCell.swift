//
//  StatsCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/14/25.
//

import SwiftUI

struct StatsCell: View {
    
    let userName: String
    let userImageData: Data?
    
    let NFTCount: Int
    
    private let textFont: Font = .system(size: 22, weight: .bold)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.yaLightGrey)
            
            cellInfo
                .padding(.horizontal, 16)
                .padding(.vertical, 26)
        }
        .frame(height: 80)
    }
    
    private var cellInfo: some View {
        GeometryReader { geometry in
            HStack(spacing: 8) {
                Image(data: userImageData, placeholder: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 28)
                    .clipShape(Circle())
                
                Text(userName)
                    .font(textFont)
                Spacer()
                Text("\(NFTCount)")
                    .font(textFont)
            }
        }
    }
}


