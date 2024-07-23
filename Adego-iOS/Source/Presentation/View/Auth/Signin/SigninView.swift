//
//  SigninView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI
import ComposableArchitecture
import AuthenticationServices

struct SigninView: View {
    @Perception.Bindable var store: StoreOf<SigninCore>
    
    private var appleSignInDelegate: AppleSignInDelegate

        init(store: StoreOf<SigninCore>) {
            self._store = Perception.Bindable(store)
            self.appleSignInDelegate = AppleSignInDelegate(store: store)
        }
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                Image("AdegoMainLogo")
                
                Spacer()
                
                appleLoginButton
                
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

extension SigninView {
    private var appleLoginButton: some View {
        Button {
            appleSignInDelegate.performSignIn()
        } label: {
            Image("AppleLoginImage")
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
