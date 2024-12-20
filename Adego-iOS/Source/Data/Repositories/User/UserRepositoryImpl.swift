//
//  UserRepositoryImpl.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation
import Moya

class UserRepositoryImpl: UserRepository {
    
    private let provider: MoyaProvider<UserService>
    
    init(provider: MoyaProvider<UserService> = MoyaProvider<UserService>()) {
        self.provider = provider
    }
    
    func updateUserName(
        name: String,
        accessToken: String
    ) async throws -> UserNameResponse {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(.updateUserName(name: name, accessToken: accessToken)) { result in
                switch result {
                case let .success(response):
                    do {
                        if let jsonString = String(data: response.data, encoding: .utf8) {
                            print("✅UserRepositoryImpl.updateUserName Response JSON: \(jsonString)")
                        }
                        
                        let userNameResponse = try JSONDecoder().decode(UserNameResponse.self, from: response.data)
                        continuation.resume(returning: userNameResponse)
                    } catch {
                        do {
                            let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                            continuation.resume(throwing: decodedError)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    }
                case let .failure(error):
                    print("🚫UserRepositoryImpl.updateUserName Network error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getUser(
        accessToken: String
    ) async throws -> User {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(.getUser(accessToken: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("✅UserRepositoryImpl.getUser Response JSON: \(jsonString)")
                    }
                    
                    let userInfo = try JSONDecoder().decode(User.self, from: response.data)
                    continuation.resume(returning: userInfo)
                } catch {
                    do {
                        let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        continuation.resume(throwing: decodedError)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            case let .failure(error):
                print("🚫UserRepositoryImpl.getUser error: \(error)")
                continuation.resume(throwing: error)
            }
        }
        }
    }
    
    func registerProfileImage(
        profileImage: String,
        accessToken: String
    ) async throws -> ProfileImageResponse {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(.registerProfileImage(profileImage: profileImage, accessToken: accessToken)) { result in
                switch result {
                case let .success(response):
                    do {
                        if let jsonString = String(data: response.data, encoding: .utf8) {
                            print("Response JSON: \(jsonString)")
                        }
                        
                        let userInfo = try JSONDecoder().decode(ProfileImageResponse.self, from: response.data)
                        continuation.resume(returning: userInfo)
                    } catch {
                        do {
                            let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                            continuation.resume(throwing: decodedError)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    }
                case let .failure(error):
                    print("Network error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func deleteUser(
        accessToken: String
    ) async throws -> DeleteUser {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(.deleteUser(accessToken: accessToken)) { result in
                switch result {
                case let .success(response):
                    do {
                        if let jsonString = String(data: response.data, encoding: .utf8) {
                            print("Response JSON: \(jsonString)")
                        }
                        
                        let response = try JSONDecoder().decode(DeleteUser.self, from: response.data)
                        continuation.resume(returning: response)
                    } catch {
                        do {
                            let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                            continuation.resume(throwing: decodedError)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    }
                case let .failure(error):
                    print("Network error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
