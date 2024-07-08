//
//  SelectLocationCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import ComposableArchitecture

@Reducer
struct SelectLocationCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State {
        
        var serchWord: String = ""
        
        let promiseLocationInfo = [
            PromiseLocation(locationName: "알파", address: "대구소프트웨어마이스터고등학교"),
            PromiseLocation(locationName: "메일", address: "대구소프트웨어마이스터고등학교"),
            PromiseLocation(locationName: "최시훈", address: "대구소프트웨어마이스터고등학교")
        ]
    }
    
    enum Action: ViewAction {
        case getAddressList
        case navigateToCreatePromiseCompleatView
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
            case .getAddressList:
                
                return .none
//                return .run (
//                    operation: try await
//                )
            case .navigateToCreatePromiseCompleatView:
                flow.push(
                    CreatePromiseCompleteView(
                        store: Store(
                            initialState: CreatePromiseCompleteCore.State()
                        ) {
                            CreatePromiseCompleteCore()
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

