//
//  SigninCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import ComposableArchitecture

@Reducer
struct SigninCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case navigateToSetName
        case kakaoLogin
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .navigateToSetName:
                
                flow.push(
                    SetNameView(
                        store: Store(
                            initialState: SetNameCore.State()
                        ) {
                            SetNameCore()
                        }
                    )
                )
                return .none
            case .kakaoLogin:
                
                return .none
            }
        }
    }
    // MARK: - func
    
}


