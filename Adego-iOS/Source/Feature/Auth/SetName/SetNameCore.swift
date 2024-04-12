//
//  SetNameCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import ComposableArchitecture

@Reducer
struct SetNameCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        var isFormValid: Bool = false
        var nameLength: Int = 0
        var name: String = ""
        
        public init() {}
    }
    
    enum Action: ViewAction {
        case navigateToSetProfileImage
        case view(View)

    }
    
    @CasePathable
    public enum View: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }
    
    public init() {}
    
    var body: some Reducer<State, Action> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .navigateToSetProfileImage:
                flow.push(
                    SetProfileImageView(
                        store: Store(
                            initialState: SetProfileImageCore.State()
                        ) {
                            SetProfileImageCore()
                        }
                    )
                )
                return .none
            case .view(.binding):
                state.isFormValid = !state.name.isEmpty
                return .none
            }
        }
    }
    // MARK: - func
    
}
