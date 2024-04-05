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
    
    let linkNavigator: LinkNavigatorType
    
    public static var liveValue: AppSideEffect {
        .init(
            linkNavigator: navigator

        )
    }
}

extension DependencyValues {
    var sideEffect: AppSideEffect {
        get { self[AppSideEffect.self] }
        set { self[AppSideEffect.self] = newValue }
    }
}
