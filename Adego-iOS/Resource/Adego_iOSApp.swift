//
//  Adego_iOSApp.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI
import FlowKit
import ComposableArchitecture

struct FlowDependency: DependencyKey {
    static var liveValue: FlowProvider {
        FlowProvider(
            rootView: SigninView(
                store: Store(
                    initialState: SigninCore.State()
                ) {
                    SigninCore()
                }
            )
        ) { rootView in
            CustomNavigationBarController(rootViewController: rootView)
        }
    }
}

extension DependencyValues {
    var flow: FlowProvider {
        get { self[FlowDependency.self] }
        set { self[FlowDependency.self] = newValue }
    }
}

@main
struct Adego_iOSApp: App {
    @Dependency(\.flow) var flow
    var body: some Scene {
        WindowGroup {
            flow.present()
                .ignoresSafeArea()
                .navigationBarHidden(true)
        }
    }
}
