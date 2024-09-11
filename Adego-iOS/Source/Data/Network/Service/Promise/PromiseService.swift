//
//  PromiseService.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation
import Moya

enum PromiseService {
    case getPromise(accessToken: String)
    case createPromise(name: String, address: String, date: String)
    case deletePromise(accessToken: String)
    case inviteUserToPromise(accessToken: String)
}

extension PromiseService: TargetType {
    var baseURL: URL {
        return URL(string: "https://adego.plebea.com")!
    }
    
    var path: String {
        switch self {
        case .getPromise:
            return "/plan"
        case .createPromise:
            return "/plan"
        case .deletePromise:
            return "/plan"
            
        case .inviteUserToPromise:
            return "/plan/invite"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPromise:
            return .get
        case .createPromise:
            return .post
        case .deletePromise:
            return .delete
            
        case .inviteUserToPromise:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getPromise:
            return .requestPlain
        case let .createPromise(name, address, date):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "address": address,
                    "date": date
                ],
                encoding: JSONEncoding.default
            )
        case .deletePromise:
            return .requestPlain
            
        case .inviteUserToPromise:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getPromise(let accessToken):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
        case .createPromise:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(savedAccessToken)"
            ]
            
        case .deletePromise(let accessToken):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
        case .inviteUserToPromise(let accessToken):
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
