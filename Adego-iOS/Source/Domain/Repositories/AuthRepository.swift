//
//  AuthRepository.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/9/24.
//

import Foundation

protocol AuthRepository {
    func signIn(
        access_token: String,
        completion: @escaping (Result<OAuthTokens, Error>) -> Void
    )
}
