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
        
    }
    
    enum Action: ViewAction {
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
            switch action {
            case .showLogoutAlert:
                logout()
                return .none
                
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
            
            func logout() {
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
                        secondaryButton: .cancel { }
                    )
                )
            }
            func expireToken() {
                
            }
            
        }
    }
}
