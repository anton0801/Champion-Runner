import SwiftUI

extension Font {
    static func alkalami(size: CGFloat) -> Font {
        return Font.custom("Alkalami-Regular", size: size)
    }
}

extension Color {
    static let primaryTextColor = Color.init(red: 180/255, green: 39/255, blue: 192/255)
    static let secondaryTextColor = Color.init(red: 117/255, green: 46/255, blue: 141/255)
    static let gray = Color.init(red: 217/255, green: 217/255, blue: 217/255)
}
