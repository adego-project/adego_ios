//
//  SetNameSideEffect.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import LinkNavigator

public protocol SetNameSideEffect {
    
}


public struct SetNameSideEffectLive {
    let navigator: LinkNavigatorType
    
    public init(navigator: LinkNavigatorType) {
        self.navigator = navigator
    }
}
extension SetNameSideEffectLive: SetNameSideEffect {
    
}
