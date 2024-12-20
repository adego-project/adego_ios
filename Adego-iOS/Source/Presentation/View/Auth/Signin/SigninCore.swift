//
//  SigninCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import ComposableArchitecture
import FlowKit

@Reducer
struct SigninCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case onAppear
        case tokenRefresh
        case successSigninWithApple(String)
        case kakaoLogin
        case navigation
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(.tokenRefresh)
                }
            case .successSigninWithApple(let appleToken):
                let authRepository = AuthRepositoryImpl()
                let signinUseCase = SigninUseCase(authRepository: authRepository)
                
                return .run { send in
                    do {
                        let response = try await signinUseCase.signinWithApple(appleToken: appleToken)
                        print("✅Access Token: \(response.accessToken)")
                        print("✅Refresh Token: \(response.refreshToken)")
                        
                        await send(.tokenRefresh)
                        await send(.navigation)
                    } catch {
                        if let errorResponse = error as? ErrorResponse {
                            print("🚫SigninCore.successSigninWithApple: \(errorResponse)")
                            flow.alert(Alert(title: errorResponse.responseMessage()))
                        } else {
                            print("🚫SigninCore.successSigninWithApple: \(error.localizedDescription)")
                            flow.alert(Alert(title: "정의되지 않은 오류입니다. \n잠시후 다시 시작해주세요."))
                        }
                    }
                }
                
            case .tokenRefresh:
                return .run { send in
                    let authRepository = AuthRepositoryImpl()
                    let signinUseCase = SigninUseCase(authRepository: authRepository)
                    do {
                        let response = try await signinUseCase.tokenRefresh(refreshToken: savedRefreshToken)
                        print("✅tokenRefresh.Access Token: \(response.accessToken)")
                        await send(.navigation)
                    } catch {
                        print("🚫Sign in failed: \(error)")
                    }
                }
            case .kakaoLogin:
                
                return .none
                
            case .navigation:
                return .run { send in
                    do {
                        let userRepository = UserRepositoryImpl()
                        let getUserUseCase = UserUseCase(userRepository: userRepository)
                        let response = try await getUserUseCase.getUser(accessToken: savedAccessToken)
                        
                        print("✅SigninCore.getUser id:", response.id)
                        print("✅SigninCore.getUser name:", response.name ?? "")
                        print("✅SigninCore.getUser planId:", response.planId ?? "")
                        print("✅SigninCore.getUser profileImage:", response.profileImage ?? "")
                        if ((response.name?.isEmpty) == nil) {
                            await flow.push(
                                SetNameView(
                                    store: Store(
                                        initialState: SetNameCore.State()
                                    ) {
                                        SetNameCore()
                                    }
                                )
                            )
                        } else {
                            print("SigninCore.navigation MainView")
                            await flow.replace(
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
                    } catch {
                        if let errorResponse = error as? ErrorResponse {
                            print("🚫SigninCore.getUser error: \(errorResponse.responseMessage())")
                            flow.alert(Alert(title: errorResponse.responseMessage()))
                        } else {
                            print("🚫SigninCore.getUser error: \(error.localizedDescription)")
                            flow.alert(Alert(title: "정의되지 않은 오류입니다. \n잠시후 다시 시작해주세요."))
                        }
                    }
                }
            }
        }
    }
}
