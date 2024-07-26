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
    
    @ObservableState
    struct State: Equatable {
        var accessToken: String = ""
        var imageUrl: String = ""
        var name: String = "알파 메일 최시훈"
    }
    
    enum Action {
        case onAppear
        case showLogoutAlert
        case showSecessionAlert
        case navigateToEditView
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
            let operation: @Sendable (_ send: Send<Action>) async throws -> Void = { send in
                try await logout()
            }
            
            switch action {
            case .onAppear:
                getUser()
                return .none
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
//                flow.alert(
//                    Alert(
//                        title: "계정에서 로그아웃 하시겠습니까?",
//                        primaryButton: .destructive(
//                            "로그아웃",
//                            action: {
//                                flow.replace([
//                                    SigninView(
//                                        store: Store(
//                                            initialState: SigninCore.State()
//                                        ) {
//                                            SigninCore()
//                                        }
//                                    )
//                                ])
//                            }
//                        ),
//                        secondaryButton: .cancel { }
//                    )
//                )
            }
            
            func seccession() {
//                flow.alert(
//                    Alert(
//                        title: "계정에서 탈퇴 하시겠습니까?",
//                        primaryButton: .destructive(
//                            "탈퇴",
//                            action: {
//                                flow.replace([
//                                    SigninView(
//                                        store: Store(
//                                            initialState: SigninCore.State()
//                                        ) {
//                                            SigninCore()
//                                        }
//                                    )
//                                ])
//                            }
//                        ),
//                        secondaryButton: .cancel {
//                            flow.exit()
//                        }
//                    )
//                )
            }
            
            func getUser() {
                let userRepository = UserRepositoryImpl()
                let getUserUseCase = UserUseCase(userRepository: userRepository)
                
                getUserUseCase.getUser(accessToken: savedAccessToken) { result in
                    switch result {
                    case .success(let info):
                        print("✅SigninCore.getUser id:", info.id)
                        print("✅SigninCore.getUser name:", info.name ?? "")
                        if ((info.name?.isEmpty) != nil) {
                            flow.push(
                                SetNameView(
                                    store: Store(
                                        initialState: SetNameCore.State()
                                    ) {
                                        SetNameCore()
                                    }
                                )
                            )
                        } else {
                            flow.replace(
                                [
                                    MainView(
                                        store: Store(
                                            initialState: MainCore.State()
                                        ) {
                                            MainCore()
                                        }
                                    )
                                ]
                            )
                        }
                        
                    case .failure(let error):
                        print("🚫SigninCore.getUser error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
