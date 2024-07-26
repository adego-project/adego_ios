//
//  AddressResponse.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/15/24.
//

import Foundation

struct AddressResponse: Equatable, Codable {
    let documents: [Document]
}

struct Document: Equatable, Codable, Identifiable {
    let addressName: String
    let roadAddressName: String
    let placeName: String
    let x: String
    let y: String
    var id = UUID()
}
