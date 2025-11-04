import SwiftData

@Model
final class LikedNft {
    @Attribute(.unique) var id: String
    
    init(id: String) {
        self.id = id
    }
}
