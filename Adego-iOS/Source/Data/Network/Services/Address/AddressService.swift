//
//  AddressService.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/23/24.
//

import Foundation
import Moya

enum AddressService {
    case searchAddress(searchWord: String)
}

extension AddressService: TargetType {
    var baseURL: URL {
        return URL(string: "https://adego.plebea.com")!
    }
    
    var path: String {
        switch self {
        case .searchAddress:
            return "/address/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchAddress:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .searchAddress(searchWord):
            return .requestParameters(
                parameters: [
                    "query": searchWord
                ],
                encoding: JSONEncoding.default
            )
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .searchAddress:
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
