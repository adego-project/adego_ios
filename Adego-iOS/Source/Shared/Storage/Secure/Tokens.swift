//
//  Tokens.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

var savedAccessToken = KeychainManager.shared.loadString(key: "accessToken") ?? ""
var savedRefreshToken = KeychainManager.shared.loadString(key: "refreshToken") ?? ""
