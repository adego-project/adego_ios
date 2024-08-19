//
//  LocationRepository.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/15/24.
//

import Foundation

protocol LocationRepository {
    func getDestination(
        accessToken: String,
        completion: @escaping (Result<CordinateResponse, Error>) -> Void
    )
}

