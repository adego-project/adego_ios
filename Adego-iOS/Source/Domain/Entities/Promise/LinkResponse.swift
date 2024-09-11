//
//  LinkResponse.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/10/24.
//

import Foundation

struct LinkResponse: Codable {
    let link: String
}

struct Hospital: Codable {
    let name: String
    let distance: String
    let address: String
    let beds: [Bed]
    let emergencyMessage: [String]
    let impossibleMessage: [String]
}

struct Bed: Codable {
    let type: String
    let count: String
}

