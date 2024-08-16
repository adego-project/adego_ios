//
//  MapCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/10/24.
//

import ComposableArchitecture
import MapKit
import CoreLocation

@Reducer
struct MapCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var locations = [Location]()
        var mapRegion = MKCoordinateRegion()
        var mapLocation: Location?
        var promiseTitle: String = ""
        
        var promise: Promise
        
        static func == (lhs: MapCore.State, rhs: MapCore.State) -> Bool {
            lhs.locations == rhs.locations
        }
    }
    
    
    enum Action: ViewAction {
        case findCurrentLocation
        case updateMapRegion(Location?)
        case view(View)

    }
    
    @CasePathable
    public enum View: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.flow) var flow
    
    var locationManager: CLLocationManager?

    var body: some ReducerOf<Self> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .findCurrentLocation:
                startTask()
                return .none
                
            case .updateMapRegion(let location):
                guard let location = location else { return .none }
                state.mapRegion = MKCoordinateRegion(
                    center: location.coordinates,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.1, longitudeDelta: 0.1
                    )
                )
                return .none
                
            case .view(.binding):
                return .none
            }
            
            func startTask() {
                print("MainCore: startTask")
                let locationManager = CLLocationManager()
                let authorizationStatus = locationManager.authorizationStatus
                
                switch authorizationStatus {
                case .authorizedAlways, .authorizedWhenInUse:
                    getCurrentLocation()
                case .denied:
                    DispatchQueue.main.async {
                        UIApplication.shared.open(
                            URL(string: UIApplication.openSettingsURLString)!)
                    }
                case .restricted, .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                    getCurrentLocation()
                @unknown default:
                    return
                }
            }
            
            func getCurrentLocation() {
                let manager = CLLocationManager()
                manager.desiredAccuracy = kCLLocationAccuracyBest
                manager.requestWhenInUseAuthorization()
                
                guard let coordinate = manager.location?.coordinate else { return }
                
                state.mapRegion = MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.1, longitudeDelta: 0.1
                    )
                )
            }
        }
    }
}
