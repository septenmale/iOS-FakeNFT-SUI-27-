import Foundation

class SortSettings {
    private static let sortOptionKey = "selectedSortOption"
    
    static var selectedSortOption: SortOption {
        get {
            if let rawValue = UserDefaults.standard.string(forKey: sortOptionKey) {
                return rawValue == "byNFTCount" ? .byNFTCount : .byName
            }
            return .byName
        }
        set {
            let value = newValue == .byNFTCount ? "byNFTCount" : "byName"
            UserDefaults.standard.set(value, forKey: sortOptionKey)
        }
    }
}
