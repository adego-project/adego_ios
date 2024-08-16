//
//  Tokens.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

let savedAccessToken = KeychainManager.shared.loadString(key: "accessToken")!
let savedRefreshToken = KeychainManager.shared.loadString(key: "refreshToken")!
