import UIKit

extension UIColor {
    // Creates color from a hex string
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
            case 3: // RGB (12-bit)
                (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: CGFloat(alpha) / 255
        )
    }

    // Universal Colors
    enum Universal {
        static let gray = UIColor(red: 98 / 255, green: 92 / 255, blue: 92 / 255, alpha: 1.0)
        static let red = UIColor(red: 245 / 255, green: 107 / 255, blue: 108 / 255, alpha: 1.0)
        static let background = UIColor(red: 26 / 255, green: 27 / 255, blue: 34 / 255, alpha: 0.5)
        static let green = UIColor(red: 28 / 255, green: 159 / 255, blue: 0 / 255, alpha: 1.0)
        static let blue = UIColor(red: 10 / 255, green: 132 / 255, blue: 255 / 255, alpha: 1.0)
        static let black = UIColor(red: 26 / 255, green: 27 / 255, blue: 34 / 255, alpha: 1.0)
        static let white = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1.0)
        static let yellow = UIColor(red: 254 / 255, green: 239 / 255, blue: 13 / 255, alpha: 1.0)
    }

    // Text Colors
    static let textPrimary = UIColor.black
    static let textSecondary = UIColor.gray
    static let textOnPrimary = UIColor.white
    static let textOnSecondary = UIColor.black

    private static let yaBlackLight = UIColor(hexString: "#1A1B22")
    private static let yaBlackDark = UIColor(hexString: "#FFFFFF")
    private static let yaLightGrayLight = UIColor(hexString: "#F7F7F8")
    private static let yaLightGrayDark = UIColor(hexString: "#2C2C2E")

    static let segmentActive = UIColor { traits in
        return traits.userInterfaceStyle == .dark
        ? .yaBlackDark
        : .yaBlackLight
    }

    static let segmentInactive = UIColor { traits in
        return traits.userInterfaceStyle == .dark
        ? .yaLightGrayDark
        : .yaLightGrayLight
    }

    static let closeButton = UIColor { traits in
        return traits.userInterfaceStyle == .dark
        ? .yaBlackDark
        : .yaBlackLight
    }
}
