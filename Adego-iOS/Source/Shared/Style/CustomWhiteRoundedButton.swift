//
//  CustomWhiteRoundedButton.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/12/24.
//

import SwiftUI

struct CustomWhiteRoundedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 343, height: 56)
            .foregroundColor(.gray10)
            .background(.gray100)
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
