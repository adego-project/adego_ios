//
//  SigninView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI
import ComposableArchitecture

struct SigninView: View {
    let store: StoreOf<SigninCore>
    
    var body: some View {
        Image("AdegoMainLogo")
            .background(.yellow)
    }
}

#Preview {
    SigninView(store: Store(initialState: SigninCore.State()) {
        SigninCore()
    })
}
