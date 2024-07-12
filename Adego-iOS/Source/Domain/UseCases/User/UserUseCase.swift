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
        completion: @escaping (Result<ProfileImage, Error>) -> Void
    ) {
        userRepository.registerProfileImage(
            profileImage: profileImage,
            completion: completion
        )
    }
    
    
}
