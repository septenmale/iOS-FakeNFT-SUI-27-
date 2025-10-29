import SwiftUI

struct CatalogCell: View {
    let item: CatalogNft
    @State private var coverImage: UIImage?
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.yaLightGrey)
                
                if let coverImage = coverImage {
                    Image(uiImage: coverImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 179)
                        .clipped()
                } else {
                    ProgressView()
                        .frame(height: 179)
                }
            }
            .frame(height: 179)
            .cornerRadius(12)
            
            HStack {
                Text("\(item.title) (\(item.currentCount))")
                    .font(.bold17)
                    .foregroundColor(.yaBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
            }
            .padding(.top, 4)
        }
        .padding(.horizontal, -1)
        .padding(.vertical, 8)
        .onAppear {
            loadCoverImage()
        }
    }
    
    private func loadCoverImage() {
        guard let url = URL(string: item.catalogImage) else { return }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    await MainActor.run {
                        self.coverImage = image
                    }
                }
            } catch {
                print("Error loading cover image: \(error)")
            }
        }
    }
}

#Preview {
    CatalogCell(item: CatalogSample.catalog[0])
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
}
