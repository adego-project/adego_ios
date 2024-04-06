//
//  SigninSideEffect.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import LinkNavigator

public protocol SigninSideEffect {
    
    var moveToSetting: () -> Void { get }
}

// MARK: - MainSideEffectLive

public struct SigninSideEffectLive {
    let navigator: LinkNavigatorType
    
    public init(navigator: LinkNavigatorType) {
        self.navigator = navigator
    }
}
extension SigninEffectLive: SigninSideEffect {
    public var moveToSetting: () -> Void {
        {
            navigator.sheet(paths: ["setting"], items: [:], isAnimated: true)
        }
    }
}
