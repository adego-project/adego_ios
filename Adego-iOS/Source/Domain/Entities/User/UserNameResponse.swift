//
//  UserNameResponse.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/17/24.
//

import Foundation

struct UserNameResponse: Codable, Equatable {
    let status: String
    let data: DataType? // 왜 인지 모르겠지만 서버가 이렇게 보내줌..
}

struct DataType: Codable, Equatable {
    
}
