//
//  CatalogCell.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kira on 13.10.2025.
//

import SwiftUI

import SwiftUI

struct CatalogCell: View {
    let item: CatalogNft
    
    var body: some View {
        VStack(spacing: 0) {
            // Изображение коллекции
            ZStack {
                // Фон для изображения
                Rectangle()
                    .fill(Color.yaLightGrey)
                
                Image(item.catalogImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 343)
            }
            .frame(height: 179)
            .cornerRadius(12)
            
            HStack {
                Text("\(item.title) (\(item.currentCount))")
                    .font(.bold17)
                    .foregroundColor(.yaBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
            }
            .padding(.top, 8)
        }
        .padding(.horizontal, -1)
        .padding(.vertical, 8)
    }
}

#Preview {
    CatalogCell(item: CatalogSample.catalog[0])
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
}
