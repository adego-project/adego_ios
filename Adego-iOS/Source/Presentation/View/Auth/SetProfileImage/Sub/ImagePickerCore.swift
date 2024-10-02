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
                return .run { send in
//                    DispatchQueue.global().async {
                    print("asdf")
                        await send(.changeValue(image))
//                    }
                }
            case .changeValue(let image):
                state.selectedImage = image
                return .none
            case .dismiss:
                flow.dismiss()
                return .none
                
            case .view(.binding):
                return .none
            }
        }
    }
}
