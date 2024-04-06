//
//  SetNameRouteBuilder.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import LinkNavigator

struct SetNameRouteBuilder: RouteBuilder {
    
    var matchPath: String { "setName" }
    
    var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
        { _, items, _ in
            WrappingController(matchPath: matchPath) {
                SetNameView(
                    selection: .constant(0),
                    store: .init(
                        initialState: SetNameCore.State(),
                        reducer: {
                            SetNameCore()
                        }))
            }
        }
    }
}
