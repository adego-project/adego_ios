//
//  AuthService.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/10/24.
//

import Foundation
import Moya

enum AuthService {
    case signIn(appleToken: String)
    case tokenRefresh(accessToken: String)
}

extension AuthService: TargetType {
    var baseURL: URL {
        return URL(string: "https://adego.plebea.com")!
    }

    var path: String {
        switch self {
        case .signIn:
            return "/oauth/apple/login"
        case .tokenRefresh:
            return "/auth/refresh"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signIn:
            return .post
        case .tokenRefresh:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .signIn(appleToken):
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
        case .signIn:
            return [
                "Content-Type": "application/json"
            ]
        case .tokenRefresh(accessToken: let accessToken):
            var headers = ["Content-type": "application/json"]
            headers["Authorization"] = "Bearer \(accessToken)"
            return headers
        }
    }

    var sampleData: Data {
        return Data()
    }
}
