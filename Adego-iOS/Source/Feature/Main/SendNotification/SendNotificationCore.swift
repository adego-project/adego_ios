//
//  SendNotificationCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/16/24.
//

import ComposableArchitecture

@Reducer
struct SendNotificationCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State {
        
        let userName = [
            SendUser(image: "알파", name: "대구소프트웨어마이스터고등학교"),
            SendUser(image: "메일", name: "대구소프트웨어마이스터고등학교"),
            SendUser(image: "메일", name: "대구소프트웨어마이스터고등학교"),
            SendUser(image: "최시훈", name: "대구소프트웨어마이스터고등학교")
        ]
        
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
