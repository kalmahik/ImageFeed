//
//  UIFont+Extentions.swift
//  ImageFeed
//
//  Created by Murad Azimov on 31.01.2024.
//

import UIKit

extension UIFont {
    enum FontType: String {
        case regular = "YSDisplay-Medium"
        case bold = "YSDisplay-Bold"
    }
    
    static func font(type: FontType, size: CGFloat) -> UIFont{
        return UIFont(name: type.rawValue, size: size)!
    }
}
