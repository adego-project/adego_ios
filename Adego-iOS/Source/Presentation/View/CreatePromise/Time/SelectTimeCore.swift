//
//  SelectTimeCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import ComposableArchitecture

@Reducer
struct SelectTimeCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var promiseTitle: String = ""
        
        var amPM: String = "오전"
        var hours: String = "4"
        var minute: String = "14"
        var selectedDate: String = ""
        var selectedAddress: String = ""
    }
    
    enum Action: ViewAction {
        case navigateToSelectLocationView
        case setValue
        case view(View)
    }
    
    @CasePathable
    public enum View: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.flow) var flow

    var body: some ReducerOf<Self> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .navigateToSelectLocationView:
                flow.push(
                    SelectLocationView(
                        store: Store(
                            initialState: SelectLocationCore.State(promiseTitle: state.promiseTitle, selectedDate: state.selectedDate)
                        ) {
                            SelectLocationCore()
                        }
                    )
                )
                return .none
            case .setValue:
                return .none
            case .view(.binding):
                return .none
            }
        }
    }
}
