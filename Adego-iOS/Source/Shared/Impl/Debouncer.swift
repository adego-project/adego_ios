//
//  Debouncer.swift
//  Adego-iOS
//
//  Created by 최시훈 on 8/5/24.
//

import Combine
import SwiftUI

class Debouncer: ObservableObject {
    private var workItem: DispatchWorkItem?
    private let delay: TimeInterval

    init(delay: TimeInterval) {
        self.delay = delay
    }

    func run(action: @escaping () -> Void) {
        workItem?.cancel()
        workItem = DispatchWorkItem(block: action)
        if let workItem = workItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
        }
    }

    func cancel() {
        workItem?.cancel()
    }
}
