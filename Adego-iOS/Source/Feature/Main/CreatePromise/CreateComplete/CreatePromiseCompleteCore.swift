//
//  CreatePromiseCompleteCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import ComposableArchitecture
import FlowKit

@Reducer
struct CreatePromiseCompleteCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        var promiseTitle: String = "같이 학교갈 팟"
        var promiseDay: String = "2024년 3월 4일"
        var promiseTime: String = "오전 6시 30분"
        var promiseLocation: String = "대구소프트웨어마이스터고등학교"
    }
    
    enum Action: ViewAction {
        case returnButton
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
            case .returnButton:
                flow.popToRoot()
                return .none
            case .view(.binding):
                return .none
            }
        }
    }
}
