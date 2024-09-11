//
//  AdressRepositoryImpl.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/23/24.
//

import Foundation
import Moya
import SwiftUI

class AddressRepositoryImpl: AddressRepository {
    
    private let provider: MoyaProvider<AddressService>
    
    init(provider: MoyaProvider<AddressService> = MoyaProvider<AddressService>()) {
        self.provider = provider
    }
    
    func searchAddress(
        searchWord: String
    ) async throws -> AddressResponse {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(.searchAddress(searchWord: searchWord)) { result in
                switch result {
                case let .success(response):
                    do {
                        if let jsonString = String(data: response.data, encoding: .utf8) {
                            print("✅PromiseRepositoryImpl.getPromise.jsonString Response JSON: \(jsonString)")
                        }
                        
                        let decodedDocument = try JSONDecoder().decode(AddressResponse.self, from: response.data)
                        continuation.resume(returning: decodedDocument)
                    } catch {
                        do {
                            let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                            continuation.resume(throwing: decodedError)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    }
                case let .failure(error):
                    print("🚫AddressRepositoryImpl.searchAddress error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
