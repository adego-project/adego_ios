//
//  KeychainManager.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation
import Security

class KeychainManager {
    static let shared = KeychainManager()
    
    private init() {}
    
    // String을 Keychain에 저장
    func save(key: String, string: String) -> Bool {
        if let data = string.data(using: .utf8) {
            return save(key: key, data: data)
        }
        return false
    }
    
    // Keychain에서 데이터를 불러와 String으로 변환
    func loadString(key: String) -> String? {
        if let loadedData = load(key: key),
           let loadedString = String(data: loadedData, encoding: .utf8) {
            return loadedString
        }
        return nil
    }
    
    // 키체인에서 데이터 삭제
    func delete(key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    // 키체인에 데이터 저장
    private func save(key: String, data: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    // 키체인에서 데이터 불러오기
    private func load(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            return dataTypeRef as? Data
        } else {
            return nil
        }
    }
}


/*
 let success = KeychainManager.shared.save(key: "token", string: "token")
 print("저장 성공: \(success)")

 if let loadedString = KeychainManager.shared.loadString(key: "token") {
     print("불러온 String: \(loadedString)")
 } else {
     print("저장된 데이터가 없습니다.")
 }

 let deleteSuccess = KeychainManager.shared.delete(key: "token")
 print("삭제 성공: \(deleteSuccess)")

 */
