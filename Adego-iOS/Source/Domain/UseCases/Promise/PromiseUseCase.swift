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
        accessToken: String
    ) async throws -> Promise {
        return try await promiseRepository.getPromise(
            accessToken: accessToken
        )
    }
    
    func createPromise(
        name: String,
        address: String,
        date: String
    ) async throws -> Promise {
        return try await promiseRepository.createPromise(
            name: name,
            address: address,
            date: date
        )
    }
    
    func deletePromise(
        accessToken: String
    ) async throws -> Promise {
        return try await promiseRepository.deletePromise(
            accessToken: accessToken
        )
    }
    
    func inviteUserToPromise(
        accessToken: String
    ) async throws -> LinkResponse {
        return try await promiseRepository.inviteUserToPromise(
            accessToken: accessToken
        )
    }
}
