//
//  CatalogNft.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kira on 13.10.2025.
//

import SwiftUI
import SwiftData

@Model
final class CatalogNft {
    @Attribute(.unique) var title: String
    
    var collection: [Collection] = []
    var catalogImage: String
    var currentCount: Int { collection.count }
        
    init(
        title: String,
        catalogImage: String
    ) {
        self.title = title
        self.catalogImage = catalogImage
    }
}
