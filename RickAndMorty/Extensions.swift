
import UIKit

public extension UIColor {
    static let black = UIColor.rgb(8, 31, 50)
    static let superLightGray = UIColor.rgb(242, 242, 247)
    static let gray = UIColor.rgb(110, 121, 140)
    static let lightGray = UIColor.rgb(239, 239, 244)
    static let lightestGray = UIColor.rgba(248, 248, 248, 0.92)
    static let purple = UIColor.rgb(88, 86, 214)
    static let borisBlue = UIColor.rgb(29, 129, 255)
}

public extension UIColor {
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor.rgba(r, g, b, 1.0)
    }
    
    static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}
