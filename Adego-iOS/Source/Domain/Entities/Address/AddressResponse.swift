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
    var id: UUID = UUID()
    
    init(addressName: String, roadAddressName: String, placeName: String, x: String, y: String, id: UUID = UUID()) {
        self.addressName = addressName
        self.roadAddressName = roadAddressName
        self.placeName = placeName
        self.x = x
        self.y = y
        self.id = id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.addressName = try container.decode(String.self, forKey: .addressName)
        self.roadAddressName = try container.decode(String.self, forKey: .roadAddressName)
        self.placeName = try container.decode(String.self, forKey: .placeName)
        self.x = try container.decode(String.self, forKey: .x)
        self.y = try container.decode(String.self, forKey: .y)
        self.id = UUID() // Generate a new UUID for id
    }
    
    enum CodingKeys: String, CodingKey {
        case addressName
        case roadAddressName
        case placeName
        case x
        case y
    }
}
