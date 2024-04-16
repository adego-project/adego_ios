//
//  PromisePreviewCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/11/24.
//

import ComposableArchitecture

@Reducer
struct PromisePreviewCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        var promiseTitle: String = "같이 학교갈 팟"
        var promiseDay: String = "2024년 3월 4일"
        var promiseTime: String = "오전 6시 30분"
        var promiseLocation: String = "대구소프트웨어마이스터고등학교"
        var isPromiseValid: Bool = false
        var promiseTimeRemaingUntil: String = "40일 3시간 3분 뒤 시작돼요"
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
