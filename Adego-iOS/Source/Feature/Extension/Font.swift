//
//  Font.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/8/24.
//

import SwiftUI

extension Font {
    static func wantedSans(
        _ size: CGFloat = 16,
        weight: WantedSansWeight = .regular
    ) -> Font {
        let fontName = "WantedSans-\(weight.rawValue)"
        return Font.custom(fontName, size: size)
    }
}

enum WantedSansWeight: String {
    case regular = "Regular"
    case midium = "Midium"
    case extraBold = "ExtraBold"
    case black = "Black"
    case semibold = "SemiBold"
    case extraBlack = "ExtraBlack"
    case bold = "Bold"
}
