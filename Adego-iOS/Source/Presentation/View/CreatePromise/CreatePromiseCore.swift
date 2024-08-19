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
        var isFormValid: Bool = false
        var promiseTitle: String = "" {
            didSet {
                titleLength = promiseTitle.count
            }
        }
        var titleLength: Int = 0 {
            didSet {
                if titleLength > 12 {
                    isFormValid = true
                } else {
                    isFormValid = false
                }
            }
        }
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
                if state.titleLength >= 3 {
                    flow.push(
                        SelectDayView(
                            store: Store(
                                initialState: SelectDayCore.State(promiseTitle: state.promiseTitle)
                            ) {
                                SelectDayCore()
                            }
                        )
                    )
                } else {
                    flow.alert(
                        Alert(title: "제목을 3자 이상 입력해주세요")
                    )
                }
                return .none
                
            case .view(.binding):
                return .none
            }
        }
    }
}
