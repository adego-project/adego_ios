//
//  SigninView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI
import ComposableArchitecture

struct SigninView: View {
    @Perception.Bindable var store: StoreOf<SigninCore>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Image("AdegoMainLogo")
                
                Spacer()
                
                Button {
                    store.send(.navigateToSetName)
                } label: {
                    Image("AppleLoginImage")
                }
                
                Button {
                    store.send(.kakaoLogin)
                } label: {
                    Image("KakaoTalkLoginImage")
                }
                .padding(.bottom, 44)
            }
            .padding(.top, 285)
            .navigationBarBackButtonHidden(true)
            
        }
    }
}

#Preview {
    SigninView(
        store: Store(
            initialState: SigninCore.State()
        ) {
            SigninCore()
        }
    )
}
