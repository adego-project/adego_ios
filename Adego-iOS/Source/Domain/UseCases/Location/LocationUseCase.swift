//
//  LocationUseCase.swift
//  Adego-iOS
//
//  Created by 최시훈 on 10/4/24.
//

import Foundation

class LocationUseCase {
    private let locationRepository: LocationRepository
    
    init(locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
    }
    
    func getDestination(
        accessToken: String
    ) async throws -> CordinateResponse {
        return try await locationRepository.getDestination(
            accessToken: accessToken
        )
    }
}
