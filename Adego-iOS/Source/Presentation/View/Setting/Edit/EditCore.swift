//
//  EditCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/14/24.
//

import Foundation
import ComposableArchitecture
import FlowKit
import SwiftUI

@Reducer
struct EditCore: Reducer {
    
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
        case save(String)
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
            case .save(let name):
                let userRepository = UserRepositoryImpl()
                let userUseCase = UserUseCase(userRepository: userRepository)
                return .run { send in
                    do {
                        let response = try await userUseCase.updateUserName(name: name, accessToken: savedAccessToken)
                        print("✅EditCore.updateUserNam Image: \(response.status)")
                        flow.alert(
                            Alert(
                                title: "이름이 변경되었습니다.",
                                dismissButton: .default("확인") {
                                    flow.dismiss()
                                }
                            )
                        )
                        
                    } catch {
                        print("🚫EditCore.updateUserName error: \(error.localizedDescription)")
                        print(error)
                    }
                }
            case .view(.binding):
                return .none
            }
        }
    }
}

