//
//  Text.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/9/24.
//

import SwiftUI

extension Text {
    func placeholderStyle() -> Text {
        self
            .foregroundColor(Color(.gray40))
            .font(.wantedSans())
    }
    
    func whiteTitleText() -> some View {
        self
            .font(.wantedSans(24, weight: .regular))
            .foregroundStyle(.white)
            .padding(.top, 76)
    }
    
}
