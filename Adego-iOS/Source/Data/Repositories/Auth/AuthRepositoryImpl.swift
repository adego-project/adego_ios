//
//  AuthRepositoryImpl.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/9/24.
//

import Foundation
import Moya

class AuthRepositoryImpl: AuthRepository {
    
    private let provider: MoyaProvider<AuthService>
    
    init(provider: MoyaProvider<AuthService> = MoyaProvider<AuthService>()) {
        self.provider = provider
    }
    
    func signInWithApple(
        appleToken: String
    ) async throws -> OAuthTokens {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(.signInWithApple(appleToken: appleToken)) { result in
                switch result {
                case let .success(response):
                    do {
                        let tokens = try JSONDecoder().decode(OAuthTokens.self, from: response.data)
                        let _ = KeychainManager.shared.save(key: "accessToken", string: tokens.accessToken)
                        let _ = KeychainManager.shared.save(key: "refreshToken", string: tokens.refreshToken)
                        continuation.resume(returning: tokens)
                    } catch {
                        do {
                            let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                            continuation.resume(throwing: decodedError)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    }
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    
    func tokenRefresh(
        accessToken: String
    ) async throws -> TokenRefresh {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(.tokenRefresh(accessToken: accessToken)) { result in
                switch result {
                case let .success(response):
                    do {
                        let tokens = try JSONDecoder().decode(TokenRefresh.self, from: response.data)
                        continuation.resume(returning: tokens)
                    } catch {
                        do {
                            let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                            continuation.resume(throwing: decodedError)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    }
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
