//
//  StatsView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Owi Lover on 10/11/25.
//

import SwiftUI

struct StatsView: View {
    
    @State var viewModel: StatsViewModelProtocol
    
    private let countFont: Font = .system(size: 15, weight: .regular)
    
    init(viewModel: StatsViewModelProtocol? = nil) {
        self.viewModel = viewModel ?? StatsViewModel()
    }
    
    var body: some View {
        NavigationStack {
            statsListView
            .padding(.horizontal, 16)
            .padding(.top, 20)
            .background(Color.yaWhite)
            
            .onAppear {
                withAnimation {
                    viewModel.isTabBarVisible = .visible
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showActionSheet = true
                    } label: {
                        Image(systemName: "text.justify.leading")
                            .foregroundStyle(.yaBlack)
                    }
                }
            }
            .toolbar(viewModel.isTabBarVisible, for: .tabBar)
            
            .actionSheet(isPresented: $viewModel.showActionSheet) {
                ActionSheet(title: Text("Сортировка"), buttons: [
                    .default(Text("По имени")) {
                        viewModel.setFilterStrategy(.username)
                    },
                    .default(Text("По рейтингу")) {
                        viewModel.setFilterStrategy(.NFTCount)
                    },
                    .cancel(Text("Закрыть")) {
                        viewModel.showActionSheet = false
                    }
                ])
            }
            
            .navigationDestination(isPresented: $viewModel.showUserProfileView) {
                let selectedUser = viewModel.selectedUser ?? User()
                StatsUserProfileView(user: selectedUser)
                    .onAppear {
                        viewModel.isTabBarVisible = .hidden
                    }
            }
        }
    }
    
    private var statsListView: some View {
        List {
            ForEach(Array(viewModel.filteredUsers.enumerated()), id: \.element.id) { index, user in
                createCellButton(user: user, number: index + 1)
                    .background(Color.yaWhite)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .listStyle(.plain)
        .listRowSpacing(8)
    }
    
    private func createCellButton(user: User, number: Int) -> some View {
        Button {
            viewModel.selectUser(user)
        } label: {
            HStack(spacing: 8) {
                Text("\(number)")
                    .font(countFont)
                    .frame(width: 20)
                StatsCell(userName: user.name,
                          userImageData: user.imageData,
                          NFTCount: user.NFTCount)
            }
        }
        .foregroundStyle(.yaBlack)
    }
}

#Preview {
    StatsView(viewModel: StatsViewModelMock())
}

