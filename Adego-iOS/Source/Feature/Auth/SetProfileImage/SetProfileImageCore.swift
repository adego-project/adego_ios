//
//  SetProfileImageCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import ComposableArchitecture

@Reducer
struct SetProfileImageCore: Reducer {
    @Dependency(\.sideEffect.setProfileImage) private var sideEffect
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        let newState = state
        switch action {
            
        }
    }
    // MARK: - func
    
}
