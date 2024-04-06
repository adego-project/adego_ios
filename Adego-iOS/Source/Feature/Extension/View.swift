//
//  View.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import SwiftUI

struct BlackBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.black)
    }
}

extension View {
    func blackBackground() -> some View {
        self.modifier(BlackBackground())
    }
}

@resultBuilder
struct BlackBackgroundBuilder {
    static func buildBlock<Content>(_ content: Content) -> some View where Content: View {
        content
    }
}
