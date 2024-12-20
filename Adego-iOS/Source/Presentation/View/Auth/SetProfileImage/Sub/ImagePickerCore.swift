//
//  ImagePickerCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/17/24.
//

import ComposableArchitecture
import SwiftUI
import FlowKit

@Reducer
struct ImagePickerCore: Reducer {
    
    @ObservableState
    struct State {
        @Shared var selectedImage: UIImage?
        @Shared var isFormValid: Bool?
    }
    
    enum Action: ViewAction {
        case didSelectImage(UIImage)
        case changeValue(UIImage)
        case dismiss
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
            case .didSelectImage(let image):
                let userRepository = UserRepositoryImpl()
                let userUseCase = UserUseCase(userRepository: userRepository)
                return .run { send in
                    await send(.changeValue(image))
                    do {
                        let response = try await userUseCase.registerProfileImage(profileImage: convertImageToBase64(image), accessToken: savedAccessToken)
                        print("✅ImagePicker.didselectImage: \(response)")
                    } catch {
                        print(convertImageToBase64(image))
                        print("🚫ImagePicker.didselectImage: \(error.localizedDescription)")
                    }
                    
                }
                
            case .changeValue(let image):
                state.selectedImage = image
                state.isFormValid = false
                return .none
            case .dismiss:
                flow.dismiss()
                return .none
                
            case .view(.binding):
                return .none
            }
            
            @Sendable
            func convertImageToBase64(_ image: UIImage) -> String {
                guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                    return "이미지 변환에 실패하였습니다."
                }
                return imageData.base64EncodedString(options: .lineLength64Characters)
            }
        }
    }
}

