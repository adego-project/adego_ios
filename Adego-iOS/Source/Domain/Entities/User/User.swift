//
//  User.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

struct User: Codable, Equatable {
    let id: String
    let name: String?
    let planId: String?
    let profileImage: String?
    
    init(id: String, name: String?, planId: String?, profileImage: String?) {
        self.id = id
        self.name = name
        self.planId = planId
        self.profileImage = profileImage
    }
}
