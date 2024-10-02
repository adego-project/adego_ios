//
//  SetProfileImageCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import ComposableArchitecture
import UIKit
import SwiftUI
import FlowKit

@Reducer
struct SetProfileImageCore {
    
    @ObservableState
    struct State {
        var isFormValid: Bool = false
        var base64String: String = ""
        
        var isImagePickerPresented: Bool = false
        var isShowPhotoLibrary: Bool = false
        var isShowSearchView: Bool = false
        @Shared var profileImage: UIImage?
        
        init() {
            self._profileImage = Shared(nil)
        }
        
    }
    
    enum Action: ViewAction {
        case onApper
        case createAccount(UIImage)
        case refreshProfileImage(UIImage?)
        case navigate
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
            case .onApper:
                return Effect.publisher {
                    state.$profileImage.publisher
                        .compactMap { profileImage in
                            profileImage != nil ? Action.refreshProfileImage(profileImage) : nil
                        }
                }
                
            case .createAccount(let profileImage):
                print("createAccount")
                replaceRootToMain()
                return .run { send in
                    let userRepository = UserRepositoryImpl()
                    let userUseCase = UserUseCase(userRepository: userRepository)
                    do {
                        let response = try await userUseCase.registerProfileImage(profileImage: convertImageToBase64(profileImage)!)
                        print("✅SetProfileImageCore.registerProfileImage Image: \(response)")
                    } catch {
                        print("🚫SigninCore.tokenRefresh error: \(error.localizedDescription)")
                        print(error)
                    }
                }
                
            case .refreshProfileImage(let image):
                state.profileImage = image
                return .none
                
            case .navigate:
                flow.sheet(
                    ImagePickerView(
                        store: Store(
                            initialState: ImagePickerCore.State(
                                selectedImage: state.$profileImage
                            )
                        ) {
                            ImagePickerCore()
                        }
                    )
                )
                return .none
                
                //            case .imagePicker(let imagePickerAction):
                //                            switch imagePickerAction {
                //                            case .didSelectImage(let image):
                //                                state.profileImage = image
                //                                state.isImagePickerPresented = false
                //                            case .dismiss:
                //                                state.isImagePickerPresented = false
                //                            }
                //                            return .none
                
            case .view(.binding):
                return .none
            }
            
            @Sendable
            func convertImageToBase64(_ image: UIImage) -> String? {
                guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                    return "이미지 변환에 실패하였습니다."
                }
                return imageData.base64EncodedString(options: .lineLength64Characters)
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
