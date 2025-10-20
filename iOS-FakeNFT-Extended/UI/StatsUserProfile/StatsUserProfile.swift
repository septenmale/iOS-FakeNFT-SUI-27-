//
//  StatsUserProfile.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/16/25.
//

import SwiftUI

struct StatsUserProfile: View {
    let user: User
    
    var body: some View {
        Text("\(user.name)")
    }
}
