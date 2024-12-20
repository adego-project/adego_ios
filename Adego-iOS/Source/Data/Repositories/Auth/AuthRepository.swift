//
//  AuthRepository.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/9/24.
//

import Foundation

protocol AuthRepository {
    func signInWithApple(
        appleToken: String
    ) async throws -> OAuthTokens
    
    func tokenRefresh(
        refreshToken: String
    ) async throws -> TokenRefresh
}
