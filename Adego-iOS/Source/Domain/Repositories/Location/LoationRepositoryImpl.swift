//
//  LoationRepositoryImpl.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/15/24.
//

import Foundation
import Moya

class LoationRepositoryImpl: LocationRepository {
    private let provider: MoyaProvider<LocationService>
    
    init(provider: MoyaProvider<LocationService> = MoyaProvider<LocationService>()) {
        self.provider = provider
    }
    
    func getDestination(
        accessToken: String,
        completion: @escaping (Result<CordinateResponse, Error>) -> Void
    ) {
        provider.request(.getDestination(accessToken: savedAccessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    if let jsonString = String(data: response.data, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }
                    
                    let response = try JSONDecoder().decode(CordinateResponse.self, from: response.data)
                    completion(.success(response))
                } catch {
                    print("getDestination Decoding error: \(error)")
                    completion(.failure(error))
                }
            case let .failure(error):
                print("getDestination Network error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
