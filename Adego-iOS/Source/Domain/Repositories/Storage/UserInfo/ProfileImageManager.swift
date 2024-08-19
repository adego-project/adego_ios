//
//  ProfileImageManager.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/19/24.
//

import Foundation

enum ProfileImageCase {
    case base64String
}

class ProfileImageManager {
    static func save(_ base64: ProfileImageCase, _ value: String) {
        UserDefaults.standard.set(value, forKey: String(describing: base64))
    }
    
    static func get(_ base64: ProfileImageCase) -> String? {
        return UserDefaults.standard.string(forKey: String(describing: base64))
    }
    
    static func remove(_ base64: ProfileImageCase) {
        UserDefaults.standard.removeObject(forKey: String(describing: base64))
    }
    
}
