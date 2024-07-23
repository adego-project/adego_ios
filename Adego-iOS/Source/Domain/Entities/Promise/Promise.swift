//
//  Promise.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

struct Promise: Codable {
    let id: String
    let name: String
    let place: Place
    let date: String
    let users: [User]
    let isAlarmAvailable: Bool
    let status: String
    let createdAt: String
}
