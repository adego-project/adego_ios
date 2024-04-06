//
//  AppSideEffect.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import Dependencies
import Foundation
import LinkNavigator

// MARK: - EmptyDependency

public struct EmptyDependency: DependencyType { }

private var navigator: LinkNavigatorType = LinkNavigator(
    dependency: EmptyDependency(),
    builders: AppRouterGroup().routers)

// MARK: - AppSideEffect

public struct AppSideEffect: DependencyKey {
    
    // SideEffect 추가
    let linkNavigator: LinkNavigatorType
    let signin: SigninSideEffect
    let setName: SetNameSideEffect
    let setProfileImage: SetProfileImageSideEffect
    
    public static var liveValue: AppSideEffect {
        .init(
            // SideEffectLive 추가
            linkNavigator: navigator,
            signin: SigninSideEffectLive(navigator: navigator),
            setName: SetNameSideEffectLive(navigator: navigator),
            setProfileImage: SetProfileImageSideEffectLive(navigator: navigator)

            

        )
    }
}

extension DependencyValues {
    var sideEffect: AppSideEffect {
        get { self[AppSideEffect.self] }
        set { self[AppSideEffect.self] = newValue }
    }
}
