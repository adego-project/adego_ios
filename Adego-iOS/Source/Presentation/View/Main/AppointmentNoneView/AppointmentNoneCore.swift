//
//  AppointmentNoneCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/29/24.
//

import ComposableArchitecture

@Reducer
struct AppointmentNoneCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action: ViewAction {
        case navigateCreatePromiseView
        case view(View)
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
            case .navigateCreatePromiseView:
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
                
            case .view(.binding):
                return .none
            }
        }
    }
}
