//
//  SigninSideEffect.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import LinkNavigator

public protocol SigninSideEffect {
    
}

// MARK: - MainSideEffectLive

public struct SigninSideEffectLive {
    let navigator: LinkNavigatorType
    
    public init(navigator: LinkNavigatorType) {
        self.navigator = navigator
    }
}

extension SigninSideEffectLive: SigninSideEffect {
    
}
