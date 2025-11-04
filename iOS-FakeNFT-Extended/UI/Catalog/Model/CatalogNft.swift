import SwiftUI
import SwiftData

@Model
final class CatalogNft {
    @Attribute(.unique) var title: String
    
    var collection: [CollectionNFT]
    var catalogImage: String
    var author: String
    var descriptionNft: String
    var currentCount: Int { collection.count }
    
    init(
        title: String,
        collection: [CollectionNFT],
        catalogImage: String,
        author: String,
        descriptionNft: String
    ) {
        self.title = title
        self.collection = collection
        self.catalogImage = catalogImage
        self.author = author
        self.descriptionNft = descriptionNft
    }
}
