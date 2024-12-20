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
        
        @Shared var isFormValid: Bool?
        @Shared var profileImage: UIImage?
        
        
        init() {
            self._isFormValid = Shared(nil)
            self._profileImage = Shared(nil)
        }
    }
    
    enum Action {
        case onAppear
        case refreshProfileImage(UIImage)
        case refreshUserInfo(User)
        case deletePromise
        case showLogoutAlert
        case showSecessionAlert
        case navigateToImagePickerView
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
                
                return .merge (
                    Effect.publisher {
                        state.$profileImage.publisher
                            .compactMap { profileImage in
                                profileImage != nil ? Action.refreshProfileImage(profileImage ?? UIImage()) : nil
                            }
                    },
                    .run { send in
                        do {
                            let response = try await getUserUseCase.getUser(accessToken: savedAccessToken)
                            print("✅SettingCore.onAppear id:", response.id)
                            print("✅SettingCore.onAppear name:", response.name ?? "")
                            await send(.refreshUserInfo(response))
                        } catch {
                            print("🚫SigninCore.getUser error: \(error.localizedDescription)")
                        }
                        
                    }
                )
                
            case .refreshProfileImage(let image):
                state.profileImage = image
                return .none
                
            case .refreshUserInfo(let response):
                state.name = response.name ?? ""
                state.imageUrl = response.profileImage!
                return .none
                
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
                                    do {
                                        let _ = try await promiseUseCase.deletePromise(accessToken: savedAccessToken)
                                        flow.popToRoot()
                                    } catch {
                                        print("🚫SettingCore.getPromise error: \(error.localizedDescription)")
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
                
            case .navigateToImagePickerView:
                flow.sheet(
                    ImagePickerView(
                        store: Store(
                            initialState: ImagePickerCore.State(
                                selectedImage: state.$profileImage,
                                isFormValid: state.$isFormValid
                            )
                        ) {
                            ImagePickerCore()
                        }
                    )
                )
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
                    print("🚫SettingCore.deleteUser error: \(error.localizedDescription)")
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
