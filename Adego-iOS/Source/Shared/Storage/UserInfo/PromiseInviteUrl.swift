//
//  PromiseInviteUrlManager.swift
//  Adego-iOS
//
//  Created by 최시훈 on 12/20/24.
//

import Foundation

enum PromiseInviteUrlCase {
    case url
}

class PromiseInviteUrlManager {
    static func save(_ url: String, _ value: String) {
        UserDefaults.standard.set(value, forKey: String(describing: url))
    }
    
    static func get(_ url: String) -> String? {
        return UserDefaults.standard.string(forKey: String(describing: url))
    }
    
    static func remove(_ url: String) {
        UserDefaults.standard.removeObject(forKey: String(describing: url))
    }
}
