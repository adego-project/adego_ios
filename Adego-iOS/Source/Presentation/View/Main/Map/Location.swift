//
//  Location.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/9/24.
//

import MapKit

struct Location: Identifiable, Equatable {
    
    var id: String {
        name
    }
    
    let name: String
    let imgaeUrl: String
    let coordinates: CLLocationCoordinate2D
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

let locations: [Location] = [
    Location(
        name: "알파 메일 최시훈",
        imgaeUrl: "",
        coordinates: CLLocationCoordinate2D(
            latitude: 41.8902, longitude: 12.4922
        )
    )
]


