//
//  Image+DataExtension.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/19/25.
//

import SwiftUI
import UIKit

extension Image {
    init(data: Data?, placeholder: String? = nil) {
        if let data, let image = UIImage(data: data) {
            self.init(uiImage: image)
        } else {
            self.init(systemName: placeholder ?? "square.slash")
            _ = self.renderingMode(.template)
        }
    }
}
