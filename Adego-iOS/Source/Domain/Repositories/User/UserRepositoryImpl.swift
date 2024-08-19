//
//  UserRepositoryImpl.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/12/24.
//

import Foundation
import Moya

class UserRepositoryImpl: UserRepository {
    
    private let provider: MoyaProvider<UserService>
    
    init(provider: MoyaProvider<UserService> = MoyaProvider<UserService>()) {
        self.provider = provider
    }
    
    func updateUserName(
        name: String,
        accessToken: String,
        completion: @escaping (Result<UserNameResponse, Error>) -> Void
    ) {
        provider.request(.updateUserName(name: name, accessToken: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("✅UserRepositoryImpl.updateUserName Response JSON: \(jsonString)")
                    }
                    
                    let userNameResponse = try JSONDecoder().decode(UserNameResponse.self, from: response.data)
                    completion(.success(userNameResponse))
                } catch {
                    print("🚫UserRepositoryImpl.updateUserName Decoding error: \(error)")
                    completion(.failure(error))
                }
            case let .failure(error):
                print("🚫UserRepositoryImpl.updateUserName Network error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func getUser(
        accessToken: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        provider.request(.getUser(accessToken: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("getUser Response JSON: \(jsonString)")
                    }
                    
                    let userInfo = try JSONDecoder().decode(User.self, from: response.data)
                    completion(.success(userInfo))
                } catch {
                    do {
                        let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(decodedError))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                print("Network error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func registerProfileImage(
        profileImage: String,
        completion: @escaping (Result<ProfileImageResponse, Error>) -> Void
    ) {
        provider.request(.registerProfileImage(profileImage: profileImage)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }
                    
                    let userInfo = try JSONDecoder().decode(ProfileImageResponse.self, from: response.data)
                    completion(.success(userInfo))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            case let .failure(error):
                print("Network error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func deleteUser(
        accessToken: String,
        completion: @escaping (Result<DeleteUser, Error>) -> Void
    ) {
        provider.request(.deleteUser(accessToken: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }
                    
                    let response = try JSONDecoder().decode(DeleteUser.self, from: response.data)
                    completion(.success(response))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            case let .failure(error):
                print("Network error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
