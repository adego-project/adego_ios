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
    
    init(name: String, imgaeUrl: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.imgaeUrl = imgaeUrl
        self.coordinates = coordinates
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

