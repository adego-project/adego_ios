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
    @Dependency(\.flow) var flow
    
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
    
    var body: some Reducer<State, Action> {
                BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .createAccount:
                flow.fullScreenSheet(
                    MainView(
                        store: Store(initialState: MainCore.State())
                        {
                            MainCore()
                        }
                    )
                )
                return .none
                
            case .setProfileImage:
                state.isImagePickerShow = true
                return .none
                
                            case .view(.binding):
//                                state.isFormValid = !state.isImagePickerShow
                                return .none
            }
        }
        // MARK: - func
    }
}
