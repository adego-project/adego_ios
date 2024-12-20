//
//  UserRepository.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

protocol UserRepository {
    func updateUserName(
        name: String,
        accessToken: String
    ) async throws -> UserNameResponse

    func getUser(
        accessToken: String
    ) async throws -> User
    
    func registerProfileImage(
        profileImage: String,
        accessToken: String
    ) async throws -> ProfileImageResponse

    func deleteUser(
        accessToken: String
    ) async throws -> DeleteUser
}
