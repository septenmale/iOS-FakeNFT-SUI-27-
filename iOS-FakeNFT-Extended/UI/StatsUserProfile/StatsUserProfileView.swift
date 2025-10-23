//
//  StatsUserProfile.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/16/25.
//

import SwiftUI

struct StatsUserProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: StatsUserProfileViewModelProtocol
    
    init(viewModel: StatsUserProfileViewModelProtocol? = nil, user: User) {
        self.viewModel = viewModel ?? StatsUserProfileViewModel(user: user)
    }
    
    private let userNameFont: Font = .system(size: 22, weight: .bold)
    private let userDescriptionFont: Font = .system(size: 13, weight: .regular)
    private let userSiteButtonTextFont: Font = .system(size: 15, weight: .regular)
    private let userNFTCollectionButtonTextFont: Font = .system(size: 17, weight: .bold)
    
    var body: some View {
            mainView
                .onAppear {
                    withAnimation {
                        viewModel.isTabBarVisible = .visible
                    }
                }
        
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
                .toolbar(viewModel.isTabBarVisible, for: .tabBar)
        
                .navigationDestination(isPresented: $viewModel.showUserNFTCollection) {
                    Text("NFTCollection")
                }
                .navigationDestination(isPresented: $viewModel.showWebView) {
                    UserProfileWebView(url: viewModel.user.website)
                        .onAppear {
                                viewModel.isTabBarVisible = .hidden
                        }
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
            Image(data: viewModel.user.imageData, placeholder: "person.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 70)
                .clipShape(Circle())
            Text("\(viewModel.user.name)")
                .font(userNameFont)
                .foregroundStyle(.yaBlack)
            Spacer()
        }
        .frame(height: 70)
    }
    
    private var userProfileDescription: some View {
        Text(viewModel.user.description)
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
                Text("Коллекция NFT (\(viewModel.user.NFTCount))")
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
            StatsUserProfileView(user: User(name: "Alex", imageData: nil, NFTCount: 39))
        }
    }
}
