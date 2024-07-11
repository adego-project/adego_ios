//
//  AuthRepositoryImpl.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/9/24.
//

import Foundation
import Moya

class AuthRepositoryImpl: AuthRepository {
    private let provider: MoyaProvider<AuthAPI>
    
    init(provider: MoyaProvider<AuthAPI> = MoyaProvider<AuthAPI>()) {
        self.provider = provider
    }
    
    func signIn(
        access_token: String,
        completion: @escaping (Result<OAuthTokens, Error>)-> Void
    ) {
        self.provider.request(.signIn(access_token: access_token)) { result in
            switch result {
            case let .success(response):
                do {
                    let tokens = try JSONDecoder().decode(OAuthTokens.self, from: response.data)
                    completion(.success(tokens))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
