import SwiftData

@Model
final class InCartNft {
    @Attribute(.unique) var id: String
    
    init(id: String) {
        self.id = id
    }
}
