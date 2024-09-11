//
//  PromiseRepositoryImpl.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation
import Moya

class PromiseRepositoryImpl: PromiseRepository {
    
    
    private let provider: MoyaProvider<PromiseService>
    
    init(provider: MoyaProvider<PromiseService> = MoyaProvider<PromiseService>()) {
        self.provider = provider
    }
    
    func getPromise(
        accessToken: String
    ) async throws -> Promise {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(.getPromise(accessToken: accessToken)) { result in
                switch result {
                case let .success(response):
                    do {
                        if let jsonString = String(data: response.data, encoding: .utf8) {
                            print("✅PromiseRepositoryImpl.getPromise.jsonString Response JSON: \(jsonString)")
                        }
                        
                        let decodedPromise = try JSONDecoder().decode(Promise.self, from: response.data)
                        continuation.resume(returning: decodedPromise)
                    } catch {
                        do {
                            let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                            continuation.resume(throwing: decodedError)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    }
                case let .failure(error):
                    print("🚫PromiseRepositoryImpl.getPromise error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func createPromise(
        name: String,
        address: String,
        date: String
    ) async throws -> Promise {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(.createPromise(name: name, address: address, date: date)) { result in
                switch result {
                case let .success(response):
                    do {
                        if let jsonString = String(data: response.data, encoding: .utf8) {
                            print("✅PromiseRepositoryImpl.getPromise.jsonString Response JSON: \(jsonString)")
                        }
                        
                        let decodedPromise = try JSONDecoder().decode(Promise.self, from: response.data)
                        continuation.resume(returning: decodedPromise)
                    } catch {
                        do {
                            let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                            continuation.resume(throwing: decodedError)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    }
                case let .failure(error):
                    print("🚫PromiseRepositoryImpl.getPromise error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func deletePromise(
        accessToken: String
    ) async throws -> Promise {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(.deletePromise(accessToken: accessToken)) { result in
                switch result {
                case let .success(response):
                    do {
                        if let jsonString = String(data: response.data, encoding: .utf8) {
                            print("✅PromiseRepositoryImpl.deletePromise.jsonString Response JSON: \(jsonString)")
                        }
                        
                        let decodedPromise = try JSONDecoder().decode(Promise.self, from: response.data)
                        continuation.resume(returning: decodedPromise)
                    } catch {
                        do {
                            let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                            continuation.resume(throwing: decodedError)
                        } catch {
                            continuation.resume(throwing: error.localizedDescription as! Error)
                        }
                    }
                case let .failure(error):
                    print("🚫PromiseRepositoryImpl.deletePromise error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    func inviteUserToPromise(
        accessToken: String
    ) async throws -> LinkResponse {
        try await withCheckedThrowingContinuation { continuation in
            
            provider.request(.inviteUserToPromise(accessToken: accessToken)) { result in
                switch result {
                case let .success(response):
                    do {
                        if let jsonString = String(data: response.data, encoding: .utf8) {
                            print("✅PromiseRepositoryImpl.inviteUserToPromise.jsonString Response JSON: \(jsonString)")
                        }
                        
                        let decodedLink = try JSONDecoder().decode(LinkResponse.self, from: response.data)
                        continuation.resume(returning: decodedLink)
                    } catch {
                        do {
                            let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                            continuation.resume(throwing: decodedError)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    }
                case let .failure(error):
                    print("🚫PromiseRepositoryImpl.inviteUserToPromise error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
