//
//  UserInfo.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/12/24.
//

import Foundation

enum UserInfo {
    case verificationID
}

class UserInfoManager {
    static func save(_ user: User, _ value: String) {
        UserDefaults.standard.set(value, forKey: String(describing: user))
    }
    
    static func get(_ user: User) -> String? {
        return UserDefaults.standard.string(forKey: String(describing: user))
    }
    
    static func remove(_ user: User) {
        UserDefaults.standard.removeObject(forKey: String(describing: user))
    }
}
