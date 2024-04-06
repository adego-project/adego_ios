//
//  AppRouterGroup.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/5/24.
//

import LinkNavigator

struct AppRouterGroup {
  var routers: [RouteBuilder] {
    [
        SigninRouteBuilder(),
        SetNameRouteBuilder(),
        SetProfileImageRouteBuilder()
        
    ]
  }
}
