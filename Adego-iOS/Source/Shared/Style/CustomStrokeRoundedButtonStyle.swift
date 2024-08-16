//
//  CustomStrokeRoundedButtonStyle.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/12/24.
//

import SwiftUI

struct CustomStrokeRoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .foregroundColor(.gray)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
