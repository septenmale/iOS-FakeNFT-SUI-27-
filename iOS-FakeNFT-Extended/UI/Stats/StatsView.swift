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
            statsScrollView
            .padding(.horizontal, 16)
            .padding(.top, 20)
            
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
                let selectedUser = viewModel.selectedUser ?? User(name: "Unknown", image: Image(systemName: "person.circle.fill"), NFTCount: 0)
                StatsUserProfile(user: selectedUser)
            }
        }
    }
    
    private var statsScrollView: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(Array(viewModel.filteredUsers.enumerated()), id: \.element.id) { index, user in
                    createCellButton(user: user, number: index + 1)
                }
            }
        }
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
                          userImage: user.image,
                          NFTCount: user.NFTCount)
            }
        }
        .foregroundStyle(.yaBlack)
    }
}

#Preview {
    StatsView(viewModel: StatsViewModelMock())
}

