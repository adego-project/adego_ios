//
//  SigninRouteBuilder.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import LinkNavigator

struct SigninRouteBuilder: RouteBuilder {
    
    var matchPath: String { "auth" }
    
    var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
        { _, items, _ in
            WrappingController(matchPath: matchPath) {
                SigninView(
                    selection: .constant(0),
                    store: .init(
                        initialState: SigninCore.State(),
                        reducer: {
                            SigninCore()
                        }))
            }
        }
    }
}
