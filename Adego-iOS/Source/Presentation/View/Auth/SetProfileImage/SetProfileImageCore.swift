//
//  SetProfileImageCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import ComposableArchitecture
import Combine
import UIKit
import SwiftUI
import FlowKit

@Reducer
struct SetProfileImageCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var isFormValid: Bool = false
        var base64String: String = ""

        var selectedImage: UIImage = UIImage()
        var isImagePickerShow: Bool = false
        var isShowPhotoLibrary: Bool = false
        var isShowSearchView: Bool = false
        
        var profileImage: UIImage = UIImage()
        var result = "First you've to select an image"
    }
    
    enum Action: ViewAction {
        case createAccount
        case refreshProfileImage
        case navigate(String, UIImage)
        case view(View)
    }
    
    @CasePathable
    public enum View: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.flow) var flow
    
    var body: some Reducer<State, Action> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .createAccount:
                print("createAccount")
                registerProfileImage()
                replaceRootToMain()
                return .none
                
            case .refreshProfileImage:
                state.profileImage = base64StringToUIImage(base64String: state.base64String) ?? UIImage()
                return .none
                
            case let .navigate(result, selectedImage):
                flow.sheet(
                    ImagePickerView(
                        store: Store(
                            initialState: ImagePickerCore.State(
                                result: result,
                                selectedImage: selectedImage
                            )
                        ) {
                            ImagePickerCore()
                        },
                        setImageCore: Store(
                            initialState: SetProfileImageCore.State()
                        ) {
                            SetProfileImageCore()
                        },
                        sourceType: .photoLibrary
                    )
                )
                return .none
                
            case .view(.binding):
                return .none
            }
            
            func registerProfileImage() {
                let base64String = ProfileImageManager.get(.base64String) ?? ""
                state.base64String = base64String
                let userRepository = UserRepositoryImpl()
                let userUseCase = UserUseCase(userRepository: userRepository)
                
                userUseCase.registerProfileImage(
                    profileImage: base64String
                ) { result in
                    switch result {
                    case .success(let response):
                        print("✅SetProfileImageCore.registerProfileImage Image: \(response)")
                    case .failure(let error):
                        print("🚫SigninCore.tokenRefresh error: \(error.localizedDescription)")
                        print(error)
                    }
                }
            }
            
            func refresh() {
                state.profileImage = base64StringToUIImage(base64String: state.base64String) ?? UIImage()
            }
            
            func base64StringToUIImage(base64String: String) -> UIImage? {
                guard let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
                        flow.alert(
                            Alert(title: "Base64 문자열을 Data로 변환하는 데 실패했습니다.")
                        )
                    return nil
                }

                let image = UIImage(data: imageData)
                return image
            }

            func replaceRootToMain() {
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
        }
    }
}
