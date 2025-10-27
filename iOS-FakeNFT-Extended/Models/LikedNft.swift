//
//  LikedNft.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/27/25.
//

import SwiftData

@Model
class LikedNft {
    @Attribute(.unique) var id: String

    init(id: String) {
        self.id = id
    }
}
