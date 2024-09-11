//
//  Promise.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

struct Promise: Codable, Equatable {
    let id: String
    let name: String
    let place: Place
    let date: String
    let users: [User]
    let isAlarmAvailable: Bool
    let status: String
    let createdAt: String
    
    init(
        id: String = "",
        name: String = "",
        place: Place = Place(id: "", name: "", address: "", x: "", y: "", planId: ""),
        date: String = "",
        users: [User] = [],
        isAlarmAvailable: Bool = false,
        status: String = "",
        createdAt: String = ""
    ) {
        self.id = id
        self.name = name
        self.place = place
        self.date = date
        self.users = users
        self.isAlarmAvailable = isAlarmAvailable
        self.status = status
        self.createdAt = createdAt
    }
}
