//
//  WhiteTitleText.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import SwiftUI

struct WhiteTitleText: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.wantedSans(24, weight: .regular))
            .foregroundStyle(.white)
            .padding(.top, 76)
    }
}
