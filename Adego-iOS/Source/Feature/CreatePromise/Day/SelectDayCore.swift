//
//  SelectDayCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import ComposableArchitecture
import FlowKit
import Foundation

@Reducer
struct SelectDayCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        var date: Date = Date()
    }
    
    enum Action: ViewAction {
        case navigateToSelectTimeView
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
            case .navigateToSelectTimeView:
                flow.push(
                    SelectTimeView(
                        store: Store(
                            initialState: SelectTimeCore.State()
                        ) {
                            SelectTimeCore()
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
