//
//  AppDelegate.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import SwiftUI
import LinkNavigator

final class AppDelegate: NSObject {
  var navigator: LinkNavigator {
    LinkNavigator(dependency: AppDependency(), builders: AppRouterGroup().routers)
  }
}

extension AppDelegate: UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    true
  }
}
