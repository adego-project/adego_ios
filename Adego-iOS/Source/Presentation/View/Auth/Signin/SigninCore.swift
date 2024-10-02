//
//  SigninCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import ComposableArchitecture

@Reducer
struct SigninCore: Reducer {
    @Dependency(\.flow) var flow
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case successSigninWithApple(String)
        case kakaoLogin
        case navigation
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .successSigninWithApple(let appleToken):
                let authRepository = AuthRepositoryImpl()
                let signinUseCase = SigninUseCase(authRepository: authRepository)
                
                return .run { send in
                    do {
                        let response = try await signinUseCase.signinWithApple(appleToken: appleToken)
                        print("✅Access Token: \(response.accessToken)")
                        print("✅Refresh Token: \(response.refreshToken)")
                        
                        await tokenRefresh(accessToken: response.refreshToken)
                        await send(.navigation)
                    } catch {
                        print("🚫Sign in failed: \(error.localizedDescription)")
                        print(error)
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
                        if ((response.name?.isEmpty) != nil) {
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
                    } catch {
                        print("🚫SigninCore.getUser error: \(error.localizedDescription)")
                        print(error)
                    }
                }
            }
            
            // MARK: - func
            @Sendable 
            func tokenRefresh(
                accessToken: String
            ) async {
                let authRepository = AuthRepositoryImpl()
                let signinUseCase = SigninUseCase(authRepository: authRepository)
                do {
                    let response = try await signinUseCase.tokenRefresh(accessToken: accessToken)
                    print("✅tokenRefresh.Access Token: \(response.accessToken)")
                } catch {
                    print("🚫SigninCore.tokenRefresh error: \(error.localizedDescription)")
                    print(error)
                }
            }
        }
    }
}
