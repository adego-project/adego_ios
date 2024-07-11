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
        access_token: String,
        completion: @escaping (Result<OAuthTokens, Error>) -> Void
    ) {
        authRepository.signIn(
            access_token: access_token,
            completion: completion
        )
    }
}
