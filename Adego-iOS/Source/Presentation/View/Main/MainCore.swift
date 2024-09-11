//
//  MainCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/9/24.
//

import SwiftUI
import ComposableArchitecture
import MapKit

@Reducer
struct MainCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var isHavePromise: Bool = false
        
        var promiseLocation: String = ""
        var promiseTimeRemaingUntil: String = ""
        
        var promise: Promise = Promise()
    }
    
    enum Action {
        case onAppear
        case getPromiseSuccess(Promise)
        case setIsHavePromiseFalse
        case navigateToCreateView
        case navigateToSettingView
        case view(View)
    }
    
    @CasePathable
    public enum View: BindableAction {
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.flow) var flow
    
    var body: some ReducerOf<Self> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .onAppear:
                let promiseRepository = PromiseRepositoryImpl()
                let promiseUseCase = PromiseUseCase(promiseRepository: promiseRepository)
                return .run { send in
                    do {
                        let response = try await promiseUseCase.getPromise(accessToken: savedAccessToken)
                        await send(.getPromiseSuccess(response))
                    } catch {
                        print("🚫MainViewCore.getPromise error: \(error.localizedDescription)")
                        await send(.setIsHavePromiseFalse)
                    }
                }
                
                
            case .getPromiseSuccess(let response):
                state.isHavePromise = true
                state.promise = response
                
                return .none
                
            case .setIsHavePromiseFalse:
                state.isHavePromise = false
                
                return .none
                
            case .navigateToCreateView:
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
                
            case .navigateToSettingView:
                flow.push(
                    SettingView(
                        store: Store(
                            initialState: SettingCore.State()
                        ) {
                            SettingCore()
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
