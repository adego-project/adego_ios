//
//  LocationService.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/15/24.
//

import Foundation
import Moya

enum LocationService {
    case getDestination(accessToken: String)
}

extension LocationService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.adego.seogaemo.com")!
    }
    
    var path: String {
        switch self {
        case .getDestination:
            return "/location/participants"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDestination:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getDestination:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case let .getDestination(accessToken):
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
