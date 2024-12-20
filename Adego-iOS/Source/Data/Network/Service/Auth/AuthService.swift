//
//  AuthService.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/10/24.
//

import Foundation
import Moya

enum AuthService {
    case signInWithApple(appleToken: String)
    case tokenRefresh(refreshToken: String)
}

extension AuthService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.adego.seogaemo.com")!
    }

    var path: String {
        switch self {
        case .signInWithApple:
            return "/oauth/apple/login"
        case .tokenRefresh:
            return "/auth/refresh"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signInWithApple:
            return .post
        case .tokenRefresh:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .signInWithApple(appleToken):
            return .requestParameters(
                parameters: [
                    "accessToken": appleToken
                ],
                encoding: JSONEncoding.default
            )
        case .tokenRefresh:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .signInWithApple:
            return [
                "Content-Type": "application/json"
            ]
        case .tokenRefresh(refreshToken: let refreshToken):
            var headers = ["Content-type": "application/json"]
            headers["Authorization"] = "Bearer \(refreshToken)"
            return headers
        }
    }

    var sampleData: Data {
        return Data()
    }
}
