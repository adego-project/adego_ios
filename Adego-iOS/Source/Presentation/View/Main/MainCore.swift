//
//  MainCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/9/24.
//

import SwiftUI
import ComposableArchitecture
import MapKit
import CoreLocation

@Reducer
struct MainCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var isHavePromise: Bool = false
        
        var promiseLocation: String = ""
        var promiseTimeRemaingUntil: String = ""
    }
    
    enum Action {
        case onAppear
        case setIsHavePromiseTrue
        case setIsHavePromiseFalse
        case getUserAnnotationInfoMation
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
                return .run { send in
                    let promiseRepository = PromiseRepositoryImpl()
                    let promiseUseCase = PromiseUseCase(promiseRepository: promiseRepository)
                    promiseUseCase.getPromise(accessToken: savedAccessToken) { result in
                        switch result {
                        case .success:
                            DispatchQueue.main.async {
                                send(.setIsHavePromiseTrue)
                            }
                        case .failure(let error):
                            print("🚫MainViewCore.getPromise error: \(error.localizedDescription)")
                            DispatchQueue.main.async {
                                send(.setIsHavePromiseFalse)
                            }
                        }
                    }
                }
                
            case .setIsHavePromiseTrue:
                    state.isHavePromise = true
                    return .none
                
            case .setIsHavePromiseFalse:
                    state.isHavePromise = false
                
                return .none
            case .getUserAnnotationInfoMation:
                //    UserAnnotationInfo 가져오는 코드 작성
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
