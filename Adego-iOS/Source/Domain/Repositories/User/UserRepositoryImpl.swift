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
    
    func getUser(
        accessToken: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        self.provider.request(.getUser(accessToken: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }
                    
                    let userInfo = try JSONDecoder().decode(User.self, from: response.data)
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
    
    func registerProfileImage(
        profileImage: String,
        completion: @escaping (Result<ProfileImage, Error>) -> Void
    ) {
        self.provider.request(.registerProfileImage(profileImage: profileImage)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }
                    
                    let userInfo = try JSONDecoder().decode(ProfileImage.self, from: response.data)
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
}
