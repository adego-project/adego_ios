//
//  SetProfileImageRouteBuilder.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/7/24.
//

import LinkNavigator

struct SetProfileImageRouteBuilder: RouteBuilder {
    
    var matchPath: String { "setProfileImage" }
    
    var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
        { _, items, _ in
            WrappingController(matchPath: matchPath) {
                SetProfileImageView(
                    store: .init(
                        initialState: SetProfileImageCore.State(),
                        reducer: {
                            SetProfileImageCore()
                        }))
            }
        }
    }
}
