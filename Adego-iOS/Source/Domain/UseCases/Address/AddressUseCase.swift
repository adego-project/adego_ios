//
//  AddressUseCase.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/23/24.
//

import Foundation

class AddressUseCase {
    private let addressRepository: AddressRepository
    
    init(addressRepository: AddressRepository) {
        self.addressRepository = addressRepository
    }
    
    func searchAddress(
        searchWord: String,
        completion: @escaping (Result<AddressResponse, Error>) -> Void
    ) {
        addressRepository.searchAddress(
            searchWord: searchWord,
            completion: completion
        )
    }
}
