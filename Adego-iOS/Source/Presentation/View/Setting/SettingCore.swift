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
        case deletePromise
        case showLogoutAlert
        case showSecessionAlert
        case setValue(User)
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
            switch action {
            case .onAppear:
                let userRepository = UserRepositoryImpl()
                let getUserUseCase = UserUseCase(userRepository: userRepository)
                
                return .run { send in
                    getUserUseCase.getUser(accessToken: savedAccessToken) { result in
                        switch result {
                        case .success(let response):
                            print("✅SigninCore.getUser id:", response.id)
                            print("✅SigninCore.getUser name:", response.name ?? "")
                            DispatchQueue.main.async {
                                send(.setValue(response))
                            }
                        case .failure(let error):
                            print("🚫SigninCore.getUser error: \(error.localizedDescription)")
                        }
                    }
                }
                
            case .deletePromise:
               
                return .run { send in
                    flow.alert(
                        Alert(
                            title: "약속에서 나가시겠습니까?",
                            primaryButton: .destructive(
                                "나가기",
                                action: {
                                    let promiseRepository = PromiseRepositoryImpl()
                                    let promiseUseCase = PromiseUseCase(promiseRepository: promiseRepository)
                                    promiseUseCase.deletePromise(accessToken: savedAccessToken) { result in
                                        switch result {
                                        case .success:
                                            flow.popToRoot()
                                        case .failure(let error):
                                            print("🚫MainViewCore.getPromise error: \(error.localizedDescription)")
                                        }
                                    }
                                }
                            ), secondaryButton: .cancel()
                        )
                    )
                }
                
            case .showLogoutAlert:
                flow.alert(
                    Alert(
                        title: "계정에서 로그아웃 하시겠습니까?",
                        primaryButton: .destructive(
                            "로그아웃",
                            action: {
                                replaceToSigninView()
                            }
                        ),
                        secondaryButton: .cancel()
                    )
                )
                return .none
                
            case .showSecessionAlert:
                flow.alert(
                    Alert(
                        title: "계정에서 탈퇴 하시겠습니까?",
                        primaryButton: .destructive(
                            "탈퇴",
                            action: {
                                deleteUser()
                            }
                        ),
                        secondaryButton: .cancel()
                    )
                )
                return .none
                
            case .setValue(let response):
                state.name = response.name ?? ""
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
            
            func deleteUser() {
                let userRepository = UserRepositoryImpl()
                let getUserUseCase = UserUseCase(userRepository: userRepository)
                getUserUseCase.deleteUser(accessToken: savedAccessToken) { result in
                    switch result {
                    case .success:
                        replaceToSigninView()
                    case .failure(let error):
                        print("🚫SigninCore.deleteUser error: \(error.localizedDescription)")
                    }
                }
            }
            
            @Sendable
            func replaceToSigninView() {
                DispatchQueue.main.async {
                    let signinStore = Store(
                        initialState: SigninCore.State()
                    ) {
                        SigninCore()
                    }
                    
                    let signinView = SigninView(store: signinStore)
                    
                    flow.replace([signinView])
                }
            }
        }
    }
}
