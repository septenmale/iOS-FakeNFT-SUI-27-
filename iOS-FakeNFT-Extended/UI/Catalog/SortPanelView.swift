import SwiftUI

struct SortPanelView: View {
    @Binding var selectedSortOption: SortOption
    @Binding var isShowingSortOptions: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Сортировка")
                .font(.regular13)
            // TODO: добавить серый
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 12)
            
            Rectangle()
            // TODO: добавить серый
                .fill(Color.primary.opacity(0.3))
                .frame(height: 0.5)
            
            VStack(spacing: 0) {
                sortOptionRow(title: "По названию", option: .byName)
                
                Rectangle()
                // TODO: добавить серый
                    .fill(Color.primary.opacity(0.3))
                    .frame(height: 0.5)
                
                sortOptionRow(title: "По количеству NFT", option: .byNFTCount)
            }
            Spacer()
        }
        .frame(height: 162)
        .background(
            RoundedRectangle(cornerRadius: 13)
                .fill(Color.white.opacity(0.3))
                .background(.ultraThinMaterial)
        )
        .padding(.horizontal, 8)
    }
    
    private func sortOptionRow(title: String, option: SortOption) -> some View {
        Button(action: {
            selectedSortOption = option
            withAnimation(.easeInOut(duration: 0.3)) {
                isShowingSortOptions = false
            }
        }) {
            HStack {
                Text(title)
                //TODO: добавить regular20
                    .font(.regular17)
                    .foregroundColor(.uniBlue)
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 18)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    @State var selectedOption: SortOption = .byName
    @State var isShowing = true
    
    return ZStack {
        LinearGradient(
            colors: [.red, .blue, .green],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        
        VStack {
            SortPanelView(
                selectedSortOption: $selectedOption,
                isShowingSortOptions: $isShowing
            )
        }
    }
}
