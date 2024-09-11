//
//  SendNotificationCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/16/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SendNotificationCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State {
        var imageUrl: String = ""
        var users: [User] = []
        
    }
    
    enum Action: ViewAction {
        case onApear
        case setValue(Promise)
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
            case .onApear:
                let promiseRepository = PromiseRepositoryImpl()
                let promiseUseCase = PromiseUseCase(promiseRepository: promiseRepository)
                return .run { send in
                    do {
                        let response = try await promiseUseCase.getPromise(accessToken: savedAccessToken)
                        await send(.setValue(response))
                    } catch {
                        print("🚫SendNotificationCore.onApear.getPromise error:", error)
                    }
                }
            case .setValue(let response):
                state.users = response.users
                return .none
                
            case .view(.binding):
                return .none
            }
        }
    }
}
