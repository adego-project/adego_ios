//
//  AppleSigninDelegate.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/8/24.
//

import ComposableArchitecture
import AuthenticationServices
import FlowKit

class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @Perception.Bindable var store: StoreOf<SigninCore>
    
    init(store: StoreOf<SigninCore>) {
        self.store = store
    }
    
    @Dependency(\.flow) var flow
    
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
            let identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
            
            
            print("User ID: \(userIdentifier)")
            print("User Full Name: \(String(describing: fullName))")
            print("User Email: \(String(describing: email))")
            print("User identityToken: \(identityToken!)")
            store.send(.successSigninWithApple(identityToken ?? "nil"))
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
        if error.localizedDescription == "The operation couldn’t be completed. (com.apple.AuthenticationServices.AuthorizationError error 1001.)" {
            flow.alert(Alert(title: "로그인이 취소 되었습니다."))
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            fatalError("Unable to find a window scene")
        }
        
        guard let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            fatalError("Unable to find the key window")
        }
        
        return keyWindow
    }
}
