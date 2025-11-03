//
//  StatsUserProfileView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/16/25.
//

import SwiftUI

struct StatsUserProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: StatsUserProfileViewModelProtocol
    @Bindable private var user: User
    
    init(viewModel: StatsUserProfileViewModelProtocol? = nil, user: User) {
        self.viewModel = viewModel ?? StatsUserProfileViewModel()
        self.user = user
    }
    
    private let userNameFont: Font = .system(size: 22, weight: .bold)
    private let userDescriptionFont: Font = .system(size: 13, weight: .regular)
    private let userSiteButtonTextFont: Font = .system(size: 15, weight: .regular)
    private let userNFTCollectionButtonTextFont: Font = .system(size: 17, weight: .bold)
    
    var body: some View {
            mainView
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                        }
                        .foregroundStyle(.yaBlack)
                    }
                }
    
                .navigationDestination(isPresented: $viewModel.showUserNFTCollection) {
                    UserNFTCollectionView(userCollection: user.NFTCollectionIDs)
                }
                .navigationDestination(isPresented: $viewModel.showWebView) {
                    CommonWebView(url: user.website)
                }
    }
    
    private var mainView: some View {
        VStack(alignment: .leading, spacing: 20) {
            userProfileImageAndName
            userProfileDescription
            userSiteButton
                .padding(.top, 8)
            userNFTCollectionButton
                .padding(.top, 20)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
        .background(.yaWhite)
    }
    
    private var userProfileImageAndName: some View {
        HStack(spacing: 16) {
            Group {
                if !user.isLoadingImage {
                    Image(data: user.imageData, placeholder: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                } else {
                    ZStack {
                        Rectangle()
                            .fill(Color.yaLightGrey)
                        ProgressView()
                    }
                }
            }
            .frame(maxWidth: 70)
            .clipShape(Circle())
            
            Text("\(user.name)")
                .font(userNameFont)
                .foregroundStyle(.yaBlack)
            Spacer()
        }
        .frame(height: 70)
    }
    
    private var userProfileDescription: some View {
        Text(user.description)
            .font(userDescriptionFont)
            .foregroundStyle(.yaBlack)
            .multilineTextAlignment(.leading)
    }
    
    private var userSiteButton: some View {
        Button {
            viewModel.showWebView = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(lineWidth: 1)
                Text("Перейти на сайт пользователя")
                    .font(userSiteButtonTextFont)
            }
            .foregroundStyle(.yaBlack)
            .frame(height: 40)
        }
    }
    
    private var userNFTCollectionButton: some View {
        Button {
            viewModel.showUserNFTCollection = true
        } label: {
            HStack {
                Text("Коллекция NFT (\(user.NFTCount))")
                    .font(userNFTCollectionButtonTextFont)
                Spacer()
                Image(systemName: "chevron.forward")
            }
            .padding(.vertical, 16)
        }
        .foregroundStyle(.yaBlack)
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    NavigationStack {
        Button("ShowStatsUserProfile") {
            isPresented = true
        }
        .navigationDestination(isPresented: $isPresented) {
            StatsUserProfileView(user: User(name: "Alex", imageData: nil, NFTCollectionIDs: ["randomID", "anotherRandomID", "lastRandomID"], NFTCount: 39))
        }
    }
}
