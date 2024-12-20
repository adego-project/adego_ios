//
//  UserUseCase.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

class UserUseCase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func updateUserName(
        name: String,
        accessToken: String
    ) async throws -> UserNameResponse {
        return try await userRepository.updateUserName(
            name: name,
            accessToken: accessToken
        )
    }
    
    func getUser(
        accessToken: String
    ) async throws -> User {
        return try await userRepository.getUser(
            accessToken: accessToken
        )
    }
    
    func registerProfileImage(
        profileImage: String,
        accessToken: String
    ) async throws -> ProfileImageResponse {
        return try await userRepository.registerProfileImage(
            profileImage: profileImage,
            accessToken: accessToken
        )
    }
    
    func deleteUser(
        accessToken: String
    ) async throws -> DeleteUser {
        return try await userRepository.deleteUser(
            accessToken: accessToken
        )
    }
}
