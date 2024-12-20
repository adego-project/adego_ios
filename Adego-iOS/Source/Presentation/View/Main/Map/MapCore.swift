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
        var timer: Timer?
        
        var lat: String = ""
        var lan: String = ""
    }
    
    enum Action: ViewAction {
        case getDestination
        case startTimer
        case stopTimer
        case view(View)
        case updateDestination(lat: String, lan: String)
    }
    
    @CasePathable
    public enum View: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.flow) var flow
    
    var body: some ReducerOf<Self> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .getDestination:
                let locationRepository = LocationRepositoryImpl()
                let locationUseCase = LocationUseCase(locationRepository: locationRepository)
                return .run { send in
                    do {
                        let response = try await locationUseCase.getDestination(accessToken: savedAccessToken)
                        await send(.updateDestination(lat: response.userid.lat, lan: response.userid.lan))
                    } catch {
                        print("MapCore")
                    }
                }
                
            case .updateDestination(let lat, let lan):
                state.lat = lat
                state.lan = lan
                return .none
            
            case .startTimer:
                return .run { send in
                    while true {
                        try await Task.sleep(nanoseconds: 5_000_000_000)
                        await send(.getDestination)
                        print("MapCore.action startTimer")
                    }
                }
                .cancellable(id: TimerID(), cancelInFlight: true)
                
                
            case .stopTimer:
                print("MapCore.action stopTimer")
                return .cancel(id: TimerID())
            
            case .view(.binding):
                return .none
            }
        }
    }
}

struct TimerID: Hashable {}
