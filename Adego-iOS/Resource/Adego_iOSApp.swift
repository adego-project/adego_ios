//
//  Adego_iOSApp.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct Adego_iOSApp: App {
        var body: some Scene {
            WindowGroup {
                SigninView(store: Store(initialState: SigninCore.State()) {
                    SigninCore()
                })
            }
            
        }
}
