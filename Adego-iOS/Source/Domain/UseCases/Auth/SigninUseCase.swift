//
//  SignInUseCase.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/9/24.
//

import Foundation

class SigninUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func signin(
        appleToken: String,
        completion: @escaping (Result<OAuthTokens, Error>) -> Void
    ) {
        authRepository.signIn(
            appleToken: appleToken,
            completion: completion
        )
    }
    
    func tokenRefresh(
        accessToken: String,
        completion: @escaping (Result<TokenRefresh, Error>) -> Void
    ) {
        authRepository.tokenRefresh(
            accessToken: accessToken,
            completion: completion
        )
    }
}
