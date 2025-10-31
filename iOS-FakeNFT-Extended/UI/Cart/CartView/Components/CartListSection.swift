import SwiftUI

struct CartListSection: View {
    @Bindable var viewModel: CartViewModel

    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                CartCell(item: item) {
                    $viewModel.selectedItem.wrappedValue = item
                }
                .listRowSeparator(.hidden)
                .listRowInsets(.init())
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .padding(.top, 20)
    }
}
