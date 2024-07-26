//
//  OAuthTokens.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/9/24.
//

import Foundation

struct OAuthTokens: Equatable, Codable {
    var accessToken: String
    var refreshToken: String
}
