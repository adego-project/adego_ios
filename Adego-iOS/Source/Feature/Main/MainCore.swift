//
//  MainCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/9/24.
//

import SwiftUI
import ComposableArchitecture
import MapKit
import CoreLocation

@Reducer
struct MainCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        var locations: [Location]?
        var mapRegion: MKCoordinateRegion?
        var mapLocation: Location?
        
        static func == (lhs: MainCore.State, rhs: MainCore.State) -> Bool {
            lhs.locations == rhs.locations
        }
    }
    
    enum Action {
        case findCurrentLocation
        case updateMapRegion(Location?)
        case getUserAnnotationInfoMation
        case navigateToCreateView
        case navigateToSettingView
        case view(View)
    }
    
    @CasePathable
    public enum View: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .findCurrentLocation:
                startTask()
                return .none
                
            case let .updateMapRegion(location):
                guard let location = location else { return .none }
                state.mapRegion = MKCoordinateRegion(
                    center: location.coordinates,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.1, longitudeDelta: 0.1
                    )
                )
                return .none
                
            case .getUserAnnotationInfoMation:
            //    UserAnnotationInfo 가져오는 코드 작성
                return .none
                
            case .navigateToCreateView:
                flow.push(
                    CreatePromiseView(
                        store: Store(
                            initialState: CreatePromiseCore.State()
                        ) {
                            CreatePromiseCore()
                        }
                    )
                )
                return .none
                
            case .navigateToSettingView:
                flow.push(
                    SettingView(
                        store: Store(
                            initialState: SettingCore.State()
                        ) {
                            SettingCore()
                        }
                    )
                )
                return .none
                
            case .view(.binding):
                return .none
            }
            
            func startTask() {
                print("startTask: CurrentLocationcheck")
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
