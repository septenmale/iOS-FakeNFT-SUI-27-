import SwiftUI

struct CollectionView: View {
    let collection: CatalogNft
    
    var body: some View {
        Text("Hello, CollectionView!")
    }
}

#Preview {
    CollectionView(collection: CatalogSample.catalog[0])
}
