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
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .successSigninWithApple(let appleToken):
                let authRepository = AuthRepositoryImpl()
                let signinUseCase = SigninUseCase(authRepository: authRepository)
                
                signinUseCase.signin(appleToken: appleToken) { result in
                    switch result {
                    case .success(let tokens):
                        print("✅Access Token: \(tokens.accessToken)")
                        print("✅Refresh Token: \(tokens.refreshToken)")
                        
                        let saveAccessToken = KeychainManager.shared.save(key: "accessToken", string: tokens.accessToken)
                        let saveRefreshToken = KeychainManager.shared.save(key: "refreshToken", string: tokens.refreshToken)
                        tokenRefresh(accessToken: tokens.refreshToken)
                        getUser(accessToken: tokens.accessToken)
                    case .failure(let error):
                        print("🚫Sign in failed: \(error.localizedDescription)")
                        print(error)
                    }
                }
                return .none
            case .kakaoLogin:
                
                return .none
            }
            
            // MARK: - func
            func tokenRefresh(
                accessToken: String
            ) {
                let authRepository = AuthRepositoryImpl()
                let signinUseCase = SigninUseCase(authRepository: authRepository)
                signinUseCase.tokenRefresh(accessToken: accessToken) {  result in
                    switch result {
                    case .success(let tokens):
                        print("✅tokenRefresh.Access Token: \(tokens.accessToken)")
                    case .failure(let error):
                        print("🚫SigninCore.tokenRefresh error: \(error.localizedDescription)")
                        print(error)
                    }
                }
            }
            
            func getUser(
                accessToken: String
            ) {
                let userRepository = UserRepositoryImpl()
                let getUserUseCase = UserUseCase(userRepository: userRepository)
                getUserUseCase.getUser(accessToken: accessToken) { result in
                    switch result {
                    case .success(let info):
                        print("✅SigninCore.getUser id:", info.id)
                        print("✅SigninCore.getUser name:", info.name ?? "")
                        print("✅SigninCore.getUser planId:", info.planId ?? "")
                        print("✅SigninCore.getUser profileImage:", info.profileImage ?? "")
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
                        print(error)
                    }
                }
            }
        }
    }
}


