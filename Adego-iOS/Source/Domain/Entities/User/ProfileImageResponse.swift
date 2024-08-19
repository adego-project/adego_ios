//
//  ProfileImageResponse.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

struct ProfileImageResponse: Equatable, Codable {
    let status: String
    let data: DataType?
}
