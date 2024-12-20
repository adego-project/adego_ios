//
//  UserService.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation
import Moya

enum UserService {
    case updateUserName(name: String, accessToken: String)
    
    case getUser(accessToken: String)
    case registerProfileImage(profileImage: String, accessToken: String)
    case deleteUser(accessToken: String)
}

extension UserService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.adego.seogaemo.com")!
    }
    
    var path: String {
        switch self {
            
        case .updateUserName:
            return "/user"
            
        case .getUser:
            return "/user"
            
        case .registerProfileImage:
            return "/user/profile-image"
            
        case .deleteUser:
            return "/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .updateUserName:
            return .patch
            
        case .getUser:
            return .get
        case .registerProfileImage:
            return .put
        case .deleteUser:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case let .updateUserName(name, _):
            return .requestParameters(
                parameters: [
                    "name": name
                ],
                encoding: JSONEncoding.default
            )
            
        case .getUser(let accessToken):
            return .requestParameters(
                parameters: [
                    "Authorization": "Bearer \(accessToken)"
                ],
                encoding: URLEncoding.queryString
            )
            
        case let .registerProfileImage(profileImage, _):
            return .requestParameters(
                parameters: [
                    "profileImage": profileImage
                ],
                encoding: JSONEncoding.default
            )
        case .deleteUser:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case let .updateUserName(_, accessToken):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
        case .getUser(let accessToken):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
        case let .registerProfileImage(_, accessToken):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
        case .deleteUser(let accessToken):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}
