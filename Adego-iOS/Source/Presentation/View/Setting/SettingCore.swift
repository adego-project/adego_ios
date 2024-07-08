//
//  SettingCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/12/24.
//

import ComposableArchitecture
import FlowKit
import SwiftUI

@Reducer
struct SettingCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        var imageUrl: String = ""
        
    }
    
    enum Action {
        case showLogoutAlert
        case showSecessionAlert
        case navigateToEditView
        case view(View)
    }
    
    @CasePathable
    public enum View: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer(action: \.view)
        Reduce { state, action in
//            let operation: @Sendable (_ send: Send<Action>) async throws -> Void = { send in
//                
//            }
            
//            func runOperation(
//                priority: TaskPriority? = nil,
//                operation: @escaping @Sendable (_ send: Send<Action>) async throws -> Void,
//                catch handler: (@Sendable (_ error: Error, _ send: Send<Action>) async -> Void)? = nil
//            ) {
//                return .run(
//                    priority: priority,
//                    operation: operation,
//                    catch: handler
//                )
//            }
            
            let operation: @Sendable (_ send: Send<Action>) async throws -> Void = { send in
                try await logout()
            }
            
            switch action {
                
            case .showLogoutAlert:
                return .run(
                    operation: operation
                )
                
            case .showSecessionAlert:
                
                return .none
                
            case .navigateToEditView:
                flow.push(
                    EditView(
                        store: Store(
                            initialState: EditCore.State()
                        ) {
                            EditCore()
                        }
                    )
                )
                return .none
                
            case .view(.binding):
                return .none
            }
            
            @Sendable func logout() async throws {
                flow.alert(
                    Alert(
                        title: "계정에서 로그아웃 하시겠습니까?",
                        primaryButton: .destructive(
                            "로그아웃",
                            action: {
                                flow.replace([
                                    SigninView(
                                        store: Store(
                                            initialState: SigninCore.State()
                                        ) {
                                            SigninCore()
                                        }
                                    )
                                ])
                            }
                        ),
                        secondaryButton: .cancel { }
                    )
                )
            }
            
            func seccession() {
                flow.alert(
                    Alert(
                        title: "계정에서 탈퇴 하시겠습니까?",
                        primaryButton: .destructive(
                            "탈퇴",
                            action: {
                                flow.replace([
                                    SigninView(
                                        store: Store(
                                            initialState: SigninCore.State()
                                        ) {
                                            SigninCore()
                                        }
                                    )
                                ])
                            }
                        ),
                        secondaryButton: .cancel {
                            flow.exit()
                        }
                    )
                )
            }
            func expireToken() {
                
            }
            
        }
    }
}
