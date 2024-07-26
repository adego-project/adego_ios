//
//  AdressRepositoryImpl.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/23/24.
//

import Foundation
import Moya

class AddressRepositoryImpl: AddressRepository {
    
    private let provider: MoyaProvider<AddressService>
    
    init(provider: MoyaProvider<AddressService> = MoyaProvider<AddressService>()) {
        self.provider = provider
    }
    
    func searchAddress(
        searchWord: String,
        completion: @escaping (Result<AddressResponse, Error>) -> Void
    ) {
        provider.request(.searchAddress(searchWord: searchWord)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("✅PromiseRepositoryImpl.getPromise.jsonString Response JSON: \(jsonString)")
                    }
                    
                    let decodedDocument = try JSONDecoder().decode(AddressResponse.self, from: response.data)
                    completion(.success(decodedDocument))
                } catch {
                    do {
                        print("1")
                        let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(decodedError))
                    } catch {
                        print("2")
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                print("🚫AddressRepositoryImpl.searchAddress error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
