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
//            ContentView()
            flow.present()
                .ignoresSafeArea()
                .onOpenURL(perform: { url in
                    handleDeeplink(url)
                })
        }
    }
    func handleDeeplink(_ url: URL) {
        print(url)
        flow.fullScreenSheet(
            InvitedAppointmentView(
                store: Store(
                    initialState: InvitedAppointmentCore.State()
                ) {
                    InvitedAppointmentCore()
                }
            )
        )
        //            // URL 처리 로직
        //            if url.scheme == "myapp" {
        //                if url.host == "home" {
        //                    selectedTab = 0 // 홈 화면으로 이동
        //                } else if url.host == "profile" {
        //                    selectedTab = 1 // 프로필 화면으로 이동
        //                }
        //            }
    }
}
