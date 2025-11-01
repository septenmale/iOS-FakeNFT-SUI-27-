//
//  LikedNft.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/26/25.
//
import SwiftData

@Model
final class LikedNft {
    @Attribute(.unique) var id: String
    
    init(id: String) {
        self.id = id
    }
}
