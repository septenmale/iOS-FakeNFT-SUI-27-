import SwiftUI

struct SortPanelView: View {
    @Binding var selectedSortOption: SortOption
    @Binding var isShowingSortOptions: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Сортировка")
                .font(.regular13)
                .foregroundColor(.labelColorGrey)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 12)
            
            Rectangle()
                .fill(Color.primary.opacity(0.3))
                .frame(height: 0.5)
            
            VStack(spacing: 0) {
                sortOptionRow(title: "По названию", option: .byName)
                
                Rectangle()
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
            SortSettings.selectedSortOption = option // ← ДОБАВЬ ЭТУ СТРОКУ
            withAnimation(.easeInOut(duration: 0.3)) {
                isShowingSortOptions = false
            }
        }) {
            HStack {
                Text(title)
                    .font(.regular20)
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
    @Previewable @State var selectedOption: SortOption = .byName
    @Previewable @State var isShowing = true
    
    ZStack {
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
