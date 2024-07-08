//
//  SelectTimeCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import ComposableArchitecture

@Reducer
struct SelectTimeCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        var amPM: String = "오전"
        var hours: String = "4"
        var minute: String = "14"
        var year: String = "2006"
        var month: String = "12"
        var day: String = "03"
    }
    
    enum Action: ViewAction {
        case navigateToSelectLocationView
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
            case .navigateToSelectLocationView:
                flow.push(
                    SelectLocationView(
                        store: Store(
                            initialState: SelectLocationCore.State()
                        ) {
                            SelectLocationCore()
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

