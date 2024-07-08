//
//  Font+Ext.swift
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
    
    static func wantedSansUIFont(
        _ size: CGFloat = 16,
        weight: WantedSansWeight = .regular
    ) -> UIFont {
        let fontName = "WantedSans-\(weight.rawValue)"
        if let fontURL = Bundle.main.url(forResource: fontName, withExtension: "otf"),
           let fontData = try? Data(contentsOf: fontURL),
           let provider = CGDataProvider(data: fontData as CFData),
           let cgFont = CGFont(provider) {
            var error: Unmanaged<CFError>?
            if CTFontManagerRegisterGraphicsFont(cgFont, &error) {
                let fontDescriptor = CTFontDescriptorCreateWithAttributes([
                    kCTFontNameAttribute: fontName as CFString,
                    kCTFontSizeAttribute: size
                ] as CFDictionary)
                return UIFont(descriptor: fontDescriptor, size: size)
            } else {
                if let error = error?.takeRetainedValue() {
                    print("Failed to register font: \(error)")
                } else {
                    print("Failed to register font with an unknown error")
                }
            }
        } else {
            print("Failed to load font data")
        }
        fatalError("Failed to load font named \(fontName)")
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
