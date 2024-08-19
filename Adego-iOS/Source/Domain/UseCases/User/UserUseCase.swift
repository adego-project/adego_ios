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
        accessToken: String,
        completion: @escaping (Result<UserNameResponse, Error>) -> Void
    ) {
        userRepository.updateUserName(
            name: name,
            accessToken: accessToken,
            completion: completion
        )
    }
    
    func getUser(
        accessToken: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        userRepository.getUser(
            accessToken: accessToken,
            completion: completion
        )
    }
    
    func registerProfileImage(
        profileImage: String,
        completion: @escaping (Result<ProfileImageResponse, Error>) -> Void
    ) {
        userRepository.registerProfileImage(
            profileImage: profileImage,
            completion: completion
        )
    }
    
    func deleteUser(
        accessToken: String,
        completion: @escaping (Result<DeleteUser, Error>) -> Void
    ) {
        userRepository.deleteUser(
            accessToken: accessToken,
            completion: completion
        )
    }
}
