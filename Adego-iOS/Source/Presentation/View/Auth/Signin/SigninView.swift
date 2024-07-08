//
//  SigninView.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI
import ComposableArchitecture

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
        .overlay {
            SignInWithAppleButton(
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        appleSignInDelegate.handleAuthorization(authResults)
                    case .failure(let error):
                        print(error.localizedDescription)
                        print("error")
                    }
                }
            ).blendMode(.overlay)
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
