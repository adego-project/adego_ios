//
//  SetProfileImageCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import ComposableArchitecture
import Combine
import UIKit


@Reducer
struct SetProfileImageCore: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var isFormValid: Bool = false
        
        var selectedImage: UIImage?
        var isImagePickerShow: Bool = false
        var isShowPhotoLibrary: Bool = false
        var isShowSearchView: Bool = false
        
        var profileImage: UIImage = UIImage()
        var result = "First you've to select an image"
    }
    
    enum Action: ViewAction {
        case createAccount
        case setProfileImage
        case view(View)
    }
    
    @CasePathable
    public enum View: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.flow) var flow
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .createAccount:
                registerProfileImage()
                replaceRootToMain()
                return .none
                
            case .setProfileImage:
                state.isImagePickerShow = true
                return .none
                
            case .view(.binding):
                return .none
            }
            
            func createAccount() {
                
            }
            
            func registerProfileImage() {
                if let base64String = encodeImageToBase64(image: state.profileImage) {
                    print("✅SetProfileImageCore.createAccount Base64 Encoded String: \(base64String)")
                }
                
                let userRepository = UserRepositoryImpl()
                let userUseCase = UserUseCase(userRepository: userRepository)
                
                userUseCase.registerProfileImage(
                    profileImage: encodeImageToBase64(image: state.profileImage) ?? ""
                ) { result in
                    switch result {
                    case .success(let response):
                        print("✅SetProfileImageCore.registerProfileImage Image: \(response.profileImage)")
                    case .failure(let error):
                        print("🚫SigninCore.tokenRefresh error: \(error.localizedDescription)")
                        print(error)
                    }
                }

            }
            
            func encodeImageToBase64(image: UIImage) -> String? {
                guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                    print("🚫SetProfileImageCore.encodeImageToBase64 Error: Failed to convert image to data")
                    return nil
                }
                
                let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
                return base64String
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
        // MARK: - func
    }
}
