//
//  AppleSigninDelegate.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/8/24.
//

import ComposableArchitecture
import AuthenticationServices

class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @Perception.Bindable var store: StoreOf<SigninCore>
    
    init(store: StoreOf<SigninCore>) {
        self.store = store
    }
    
    func performSignIn() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // Sign in 성공 또는 실패 시 호출되는 함수
    func handleAuthorization(_ authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            guard let identityTokenData = appleIDCredential.identityToken else {
                print("Failed to get identity token data.")
                return
            }
            let identityTokenString = identityTokenData.base64EncodedString()
            
            
            print("User ID: \(userIdentifier)")
            print("User Full Name: \(String(describing: fullName))")
            print("User Email: \(String(describing: email))")
            print("User identityToken: \(identityTokenString)")
            
            store.send(.successSigninWithApple(identityTokenString))
        }
    }
    
    // MARK: - Success
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("authorizationController: didCompleteWithAuthorization")
        handleAuthorization(authorization)
    }
    
    // MARK: - Error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("authorizationController: didCompleteWithError - \(error.localizedDescription)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first { $0.isKeyWindow }!
    }
}
