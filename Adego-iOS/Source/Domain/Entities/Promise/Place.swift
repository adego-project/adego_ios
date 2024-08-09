//
//  Place.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/14/24.
//

import Foundation

struct Place: Codable, Equatable {
    let id: String
    let name: String
    let address: String
    let x: String
    let y: String
    let planId: String
     
    init(id: String, name: String, address: String, x: String, y: String, planId: String) {
        self.id = id
        self.name = name
        self.address = address
        self.x = x
        self.y = y
        self.planId = planId
    }
}
