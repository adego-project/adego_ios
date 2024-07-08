//
//  InvitedAppointmentCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/16/24.
//

import ComposableArchitecture

@Reducer
struct InvitedAppointmentCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State {
        var isAppointment: Bool = false
        var imageUrl: String = ""
        var name: String = "알파 메일 최시훈"
        var promiseTitle: String = "같이 학교갈 팟"
        var promiseDay: String = "2024년 3월 4일"
        var promiseTime: String = "오전 6시 30분"
        var promiseLocation: String = "대구소프트웨어마이스터고등학교"
    }
    
    enum Action: ViewAction {
        case declineInvitation

        case acceptInvitation
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
            case .declineInvitation:
                
                return .none
            case .acceptInvitation:
                flow.popToRoot()
                return .none
            case .view(.binding):
                return .none
            }
        }
    }
}
