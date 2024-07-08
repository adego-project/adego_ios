//
//  SendUser.swift
//  Adego-iOS
//
//  Created by 최시훈 on 4/16/24.
//

import Foundation

struct SendUser:Identifiable {
    var id = UUID()
    var num: Int
    var image: String
    var name: String
}
