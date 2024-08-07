//
//  UserRepository.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

protocol UserRepository {
    func getUser(
        accessToken: String,
        completion: @escaping (Result<User, Error>) -> Void
    )
    
    func registerProfileImage(
        profileImage: String,
        completion: @escaping (Result<ProfileImage, Error>) -> Void
    )
}
