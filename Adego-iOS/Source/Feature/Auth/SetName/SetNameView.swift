//
//  SetNameView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import SwiftUI
import ComposableArchitecture

struct SetNameView: View {
    let store: StoreOf<SetNameCore>

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SetNameView(store: Store(initialState: SetNameCore.State()) {
        SetNameCore()
    })
}
