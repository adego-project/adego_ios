//
//  SetProfileImageSideEffect.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import LinkNavigator

public protocol SetProfileImageSideEffect {
    
}


public struct SetProfileImageSideEffectLive {
    let navigator: LinkNavigatorType
    
    public init(navigator: LinkNavigatorType) {
        self.navigator = navigator
    }
}
extension SetProfileImageSideEffectLive: SetProfileImageSideEffect {
    
}
