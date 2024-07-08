//
//  View+Ext.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/28/24.
//

import SwiftUI


extension View {
    
    @ViewBuilder
    func cornerRadius(_ amount: CGFloat) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: amount))
    }
}
