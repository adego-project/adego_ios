//
//  GetUserUseCase.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

class GetUserUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute(
        accessToken: String,
                 completion: @escaping (Result<User, Error>) -> Void
    ) {
        userRepository.getUser(
            accessToken: accessToken,
            completion: completion
        )
    }
}
