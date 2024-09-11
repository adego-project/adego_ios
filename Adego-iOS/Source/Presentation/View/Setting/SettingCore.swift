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
        
        var selectedImage: UIImage = UIImage()
    }
    
    enum Action {
        case onAppear
        case deletePromise
        case showLogoutAlert
        case showSecessionAlert
        //        case navigate(String, UIImage)
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
                    do {
                        let response = try await getUserUseCase.getUser(accessToken: savedAccessToken)
                        print("✅SigninCore.getUser id:", response.id)
                        print("✅SigninCore.getUser name:", response.name ?? "")
                        await send(.setValue(response))
                    } catch {
                        print("🚫SigninCore.getUser error: \(error.localizedDescription)")
                    }
                    
                }
                
                
            case .deletePromise:
                
                return .run { send in
                    flow.alert(
                        Alert(
                            title: "약속에서 나가시겠습니까?"
                            //                            primaryButton: .destructive(
                            //                                "나가기",
                            //                                action: {
                            //                                    let promiseRepository = PromiseRepositoryImpl()
                            //                                    let promiseUseCase = PromiseUseCase(promiseRepository: promiseRepository)
                            //                                    promiseUseCase.deletePromise(accessToken: savedAccessToken) { result in
                            //                                        switch result {
                            //                                        case .success:
                            //                                            flow.popToRoot()
                            //                                        case .failure(let error):
                            //                                            print("🚫MainViewCore.getPromise error: \(error.localizedDescription)")
                            //                                        }
                            //                                    }
                            //                                }
                            //                            ), secondaryButton: .cancel()
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
                return .run { send in
                    flow.alert(
                        Alert(
                            title: "계정에서 탈퇴 하시겠습니까?",
                            primaryButton: .destructive(
                                "탈퇴",
                                action: {
                                    await deleteUser()
                                }
                            ),
                            secondaryButton: .cancel()
                        )
                    )
                }
                
                //            case let .navigate(result, selectedImage):
                //                flow.sheet(
                //                    ImagePickerView(
                //                        store: Store(
                //                            initialState: ImagePickerCore.State(
                //                                result: result,
                //                                selectedImage: selectedImage
                //                            )
                //                        ) {
                //                            ImagePickerCore()
                //                        },
                //                        setting: Store(
                //                            initialState: SettingCore.State()
                //                        ) {
                //                            SettingCore()
                //                        },
                //                        sourceType: .photoLibrary
                //                    )
                //                )
                //                return .none
                
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
            
            @Sendable 
            func deleteUser() async {
                let userRepository = UserRepositoryImpl()
                let getUserUseCase = UserUseCase(userRepository: userRepository)
                do {
                    _ = try await getUserUseCase.deleteUser(accessToken: savedAccessToken)
                    replaceToSigninView()
                } catch {
                    print("🚫SigninCore.deleteUser error: \(error.localizedDescription)")
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
