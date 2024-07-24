//
//  UserService.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation
import Moya

enum UserService {
    case getUser(accessToken: String)
    case registerProfileImage(profileImage: String)
    
}

extension UserService: TargetType {
    var baseURL: URL {
        return URL(string: "https://adego.plebea.com")!
    }
    
    var path: String {
        switch self {
        case .getUser:
            return "/user"
            
        case .registerProfileImage:
            return "/user/profile-image"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser:
            return .get
        case .registerProfileImage:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .getUser(let accessToken):
            return .requestParameters(parameters: [
                "Authorization": "Bearer \(accessToken)"
            ],
                                      encoding: URLEncoding.queryString)
            
        case let .registerProfileImage(profileImage):
            return .requestParameters(
                parameters: [
                    "profileImage": profileImage
                ],
                encoding: JSONEncoding.default
            )
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getUser(let accessToken):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
        case .registerProfileImage:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}
