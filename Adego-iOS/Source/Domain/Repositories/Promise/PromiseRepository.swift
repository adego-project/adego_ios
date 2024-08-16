//
//  PromiseRepository.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation

protocol PromiseRepository {
    func getPromise(
        accessToken: String,
        completion: @escaping (Result<Promise, Error>) -> Void
    )
    
    func createPromise(
        name: String,
        address: String,
        date: String,
        completion: @escaping (Result<Promise, Error>) -> Void
    )
    
    func deletePromise(
        accessToken: String,
        completion: @escaping (Result<Promise, Error>) -> Void
    )
    
    func inviteUserToPromise(
        accessToken: String,
        completion: @escaping (Result<LinkResponse, Error>) -> Void
    )
}
