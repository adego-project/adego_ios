//
//  ErrorResponse.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/9/24.
//

import Foundation

struct ErrorResponse: Error, Codable {
    let statusCode: Int
    let message: String
}
