//
//  SigninCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import ComposableArchitecture

@Reducer
struct SigninCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var isKaKaoLogin: Bool = false
        var isAppleLogin: Bool = false
    }
    
    enum Action: Equatable {
        func kakaoLogin
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        let newState = state
        switch action {
            
        }
    }
    // MARK: - func
    
}
