//
//  SetProfileImageCore.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import ComposableArchitecture
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
        
        var image: UIImage = UIImage()
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
                replaceRootToMain()
                return .none
                
            case .setProfileImage:
                state.isImagePickerShow = true
                return .none
                
            case .view(.binding):
                return .none
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
