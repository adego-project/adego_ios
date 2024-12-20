//
//  LocationManager.swift
//  Adego-iOS
//
//  Created by 최시훈 on 10/4/24.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var locationUpdatePublisher = PassthroughSubject<CLLocation, Never>()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func isLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }

    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationUpdatePublisher.send(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
