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
        accessToken: String,
        completion: @escaping (Result<Promise, Error>) -> Void
    ) {
        provider.request(.getPromise(accessToken: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("✅PromiseRepositoryImpl.getPromise.jsonString Response JSON: \(jsonString)")
                    }
                    
                    let decodedPromise = try JSONDecoder().decode(Promise.self, from: response.data)
                    completion(.success(decodedPromise))
                } catch {
                    do {
                        let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(decodedError))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                print("🚫PromiseRepositoryImpl.getPromise error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func createPromise(
        name: String,
        address: String,
        date: String,
        completion: @escaping (Result<Promise, Error>) -> Void
    ) {
        provider.request(.createPromise(name: name, address: address, date: date)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("✅PromiseRepositoryImpl.getPromise.jsonString Response JSON: \(jsonString)")
                    }
                    
                    let decodedPromise = try JSONDecoder().decode(Promise.self, from: response.data)
                    completion(.success(decodedPromise))
                } catch {
                    do {
                        let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(decodedError))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                print("🚫PromiseRepositoryImpl.getPromise error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func deletePromise(
        accessToken: String,
        completion: @escaping (Result<Promise, Error>) -> Void
    ) {
        provider.request(.deletePromise(accessToken: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("✅PromiseRepositoryImpl.deletePromise.jsonString Response JSON: \(jsonString)")
                    }
                    
                    let decodedPromise = try JSONDecoder().decode(Promise.self, from: response.data)
                    completion(.success(decodedPromise))
                } catch {
                    do {
                        let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(decodedError))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                print("🚫PromiseRepositoryImpl.deletePromise error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func inviteUserToPromise(
        accessToken: String,
        completion: @escaping (Result<LinkResponse, Error>) -> Void
    ) {
        provider.request(.inviteUserToPromise(accessToken: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("✅PromiseRepositoryImpl.inviteUserToPromise.jsonString Response JSON: \(jsonString)")
                    }
                    
                    let decodedLink = try JSONDecoder().decode(LinkResponse.self, from: response.data)
                    completion(.success(decodedLink))
                } catch {
                    do {
                        let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(decodedError))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                print("🚫PromiseRepositoryImpl.inviteUserToPromise error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
