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
    
    func signIn(
        appleToken: String,
        completion: @escaping (Result<OAuthTokens, Error>)-> Void
    ) {
        provider.request(.signIn(appleToken: appleToken)) { result in
            switch result {
            case let .success(response):
                do {
                    let tokens = try JSONDecoder().decode(OAuthTokens.self, from: response.data)
                    completion(.success(tokens))
                } catch {
                    do {
                        let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(decodedError))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func tokenRefresh(
        accessToken: String,
        completion: @escaping (Result<TokenRefresh, Error>)-> Void
    ) {
        provider.request(.tokenRefresh(accessToken: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    let tokens = try JSONDecoder().decode(TokenRefresh.self, from: response.data)
                    completion(.success(tokens))
                } catch {
                    do {
                        let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(decodedError))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
