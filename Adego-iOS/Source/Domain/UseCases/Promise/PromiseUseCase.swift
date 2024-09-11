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
    
    func deletePromise(
        accessToken: String,
        completion: @escaping (Result<Promise, Error>) -> Void
    ) {
        promiseRepository.deletePromise(
            accessToken: accessToken,
            completion: completion
        )
    }
    
    func inviteUserToPromise(
        accessToken: String,
        completion: @escaping (Result<LinkResponse, Error>) -> Void
    ) {
        promiseRepository.inviteUserToPromise(
            accessToken: accessToken,
            completion: completion
        )
    }
}
