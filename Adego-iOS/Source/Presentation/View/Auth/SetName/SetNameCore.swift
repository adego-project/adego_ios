//
//  SetNameCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import Foundation
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
                } else if nameLength == 0 {
                    isFormValid = false
                } else {
                    isFormValid = true
                }
            }
        }
    }
    
    enum Action: ViewAction {
        case next(String)
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
            case .next(let name):
                let userRepository = UserRepositoryImpl()
                let userUseCase = UserUseCase(userRepository: userRepository)
                return .run { send in
                    userUseCase.updateUserName(name: name, accessToken: savedAccessToken) { result in
                        switch result {
                        case .success(let response):
                            print("✅SetNameCore.next Image: \(response.status)")
                            
                            DispatchQueue.main.async {
                                send(.navigateToSetProfileImage)
                            }
                            
                        case .failure(let error):
                            print("🚫SigninCore.tokenRefresh error: \(error.localizedDescription)")
                            print(error)
                        }
                    }
                }

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
