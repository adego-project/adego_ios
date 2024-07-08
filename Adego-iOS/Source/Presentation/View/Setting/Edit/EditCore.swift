//
//  EditCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import ComposableArchitecture
import FlowKit

@Reducer
struct EditCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var isFormValid: Bool = false
        var name: String = "" {
            willSet {
                nameLength = name.count
            }
        }
        var nameLength: Int = 0 {
            willSet {
                if nameLength > 9 {
                    isFormValid = true
                } else {
                    isFormValid = false
                }
            }
        }
    }
    
    enum Action: ViewAction {
        case dismiss
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
            case.dismiss:
                flow.exit()
                return .none
            case .view(.binding):
                return .none
            }
        }
    }
}

