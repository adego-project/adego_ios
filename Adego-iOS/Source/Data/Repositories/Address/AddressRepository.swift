//
//  AddressRepository.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/23/24.
//

import Foundation

protocol AddressRepository {
    func searchAddress(
        searchWord: String
    ) async throws -> AddressResponse
}
