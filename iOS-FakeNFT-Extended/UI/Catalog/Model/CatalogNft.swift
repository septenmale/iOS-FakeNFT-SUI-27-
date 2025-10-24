import SwiftUI
import SwiftData

@Model
final class CatalogNft {
    @Attribute(.unique) var title: String
    
    var collection: [CollectionNFT] = []
    var catalogImage: String
    var currentCount: Int { collection.count }
    
    init(
        title: String,
        catalogImage: String
    ) {
        self.title = title
        self.catalogImage = catalogImage
    }
}
