//
//  AuthRepository.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/9/24.
//

import Foundation

protocol AuthRepository {
    func signIn(
        appleToken: String,
        completion: @escaping (Result<OAuthTokens, Error>) -> Void
    )
    
    func tokenRefresh(
        accessToken: String,
        completion: @escaping (Result<TokenRefresh, Error>) -> Void
    )
}
