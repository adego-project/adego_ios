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
    
    func signinWithApple(
        appleToken: String
    ) async throws -> OAuthTokens {
        return try await authRepository.signInWithApple(
            appleToken: appleToken
        )
    }
    
    func tokenRefresh(
        refreshToken: String
    ) async throws -> TokenRefresh {
        return try await authRepository.tokenRefresh(
            refreshToken: refreshToken
        )
    }
}
