//
//  CreatePromiseCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/12/24.
//

import ComposableArchitecture
import FlowKit

@Reducer
struct CreatePromiseCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        var titleLength: String = "3"
        var promiseTitle: String = ""
    }
    
    enum Action: ViewAction {
        case navigateToSelectDayView
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
            case .navigateToSelectDayView:
                flow.push(
                    SelectDayView(
                        store: Store(
                            initialState: SelectDayCore.State()
                        ) {
                            SelectDayCore()
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
