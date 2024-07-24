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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPromise:
            return .get
            
        case .createPromise:
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
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}
