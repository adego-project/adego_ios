//
//  PromiseRepository.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

protocol PromiseRepository {
    func getPromise(
        accessToken: String
    )  async throws -> Promise
    
    func createPromise(
        name: String,
        address: String,
        date: String
    )  async throws -> Promise
    
    func deletePromise(
        accessToken: String
    ) async throws -> Promise
    
    func inviteUserToPromise(
        accessToken: String
    )  async throws -> LinkResponse
}
