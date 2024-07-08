//
//  AppointmentNoneCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/29/24.
//

import ComposableArchitecture

@Reducer
struct AppointmentNoneCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action: ViewAction {
        
        case view(View)
    }
    
    @CasePathable
    public enum View: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
                
            case .view(.binding):
                return .none
            }
        }
    }
}
