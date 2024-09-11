//
//  CordinateResponse.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/15/24.
//

import Foundation

struct CordinateResponse: Codable, Equatable {
    let userid: UserId
}

struct UserId: Codable, Equatable {
    let lat: String
    let lan: String
}
