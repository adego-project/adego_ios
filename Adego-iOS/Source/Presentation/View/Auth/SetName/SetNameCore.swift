//
//  SetNameCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import ComposableArchitecture
import FlowKit

@Reducer
struct SetNameCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var isFormValid: Bool = false
        var name: String = "" {
            didSet {
                nameLength = name.count
            }
        }
        var nameLength: Int = 0 {
            didSet {	
                if nameLength <= 8 {
                    isFormValid = false
                } else {
                    isFormValid = true
                }
            }
        }
    }
    
    enum Action: ViewAction {
        case navigateToSetProfileImage
        case view(View)
    }
    
    @CasePathable
    public enum View: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }
        
    @Dependency(\.flow) var flow
    
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
                return .none
            }
            // MARK: - func
            func checkName(text: String) {
                
                
            }
        }
    }
}
