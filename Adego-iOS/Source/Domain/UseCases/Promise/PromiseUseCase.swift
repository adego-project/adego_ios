//
//  PromiseUseCase.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

class PromiseUseCase {
    private let promiseRepository: PromiseRepository
    
    init(promiseRepository: PromiseRepository) {
        self.promiseRepository = promiseRepository
    }
    
    func getPromise(
        accessToken: String,
        completion: @escaping (Result<Promise, Error>) -> Void
    ) {
        promiseRepository.getPromise(
            accessToken: accessToken,
            completion: completion
        )
    }
    
    func createPromise(
        name: String,
        address: String,
        date: String,
        completion: @escaping (Result<Promise, Error>) -> Void
    ) {
        promiseRepository.createPromise(
            name: name,
            address: address,
            date: date,
            completion: completion
        )
    }
}
