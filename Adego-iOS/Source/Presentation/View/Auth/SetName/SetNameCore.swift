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
        var message: String = ""
        var isFormValid: Bool = false
        var name: String = "" {
            didSet {
                nameLength = name.count
            }
        }
        var nameLength: Int = 0 {
            didSet {
                if nameLength >= 9 {
                    isFormValid = true
                    message = "글자가 너무 길어요."

                } else if 0 <= nameLength {
                    isFormValid = false
                    message = "글자가 너무 적어요."
                } else {
                    isFormValid = false
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
                if state.nameLength >= 0 {
                    let userRepository = UserRepositoryImpl()
                    let userUseCase = UserUseCase(userRepository: userRepository)
                    return .run { send in
                        do {
                            let response = try await userUseCase.updateUserName(name: name, accessToken: savedAccessToken)
                                print("✅SetNameCore.next Image: \(response.status)")
                                
                                await send(.navigateToSetProfileImage)
                            } catch {
                                if let errorResponse = error as? ErrorResponse {
                                    print("🚫SetNameCore.next: \(errorResponse)")
                                    flow.alert(Alert(title: errorResponse.responseMessage()))
                                } else {
                                    print("🚫SetNameCore.next: \(error.localizedDescription)")
                                    flow.alert(Alert(title: "정의되지 않은 오류입니다. \n잠시후 다시 시작해주세요."))
                                }
                            }
                        }
                } else {
                    flow.alert(
                        Alert(
                            title: "이름을 1자 이상 입력해주세요"
                        )
                    )
                    return .none
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
