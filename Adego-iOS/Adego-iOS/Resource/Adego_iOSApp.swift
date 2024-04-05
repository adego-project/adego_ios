//
//  Adego_iOSApp.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI
import LinkNavigator
import ComposableArchitecture

@main
struct Adego_iOSApp: App {
    @Dependency(\.sideEffect) var sideEffect
        
        
        // MARK: App
        var navigator: LinkNavigator {
            sideEffect.linkNavigator as! LinkNavigator
        }
        @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
        
        
        var body: some Scene {
            WindowGroup {
                navigator
                    .launch(paths: ["onBoarding"],
                            items: [:])
                    .ignoresSafeArea(edges: .all)
            }
        }
}
