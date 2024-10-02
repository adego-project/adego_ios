//
//  DebounceModifier.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/26/24.
//

import SwiftUI

struct DebounceModifier: ViewModifier {
    @ObservedObject private var debouncer: Debouncer
    @Binding private var value: String

    private var action: () -> Void

    init(value: Binding<String>, delay: TimeInterval, action: @escaping () -> Void) {
        self._value = value
        self.debouncer = Debouncer(delay: delay)
        self.action = action
    }

    func body(content: Content) -> some View {
        content
            .onChange(of: value) { _ in
                debouncer.run {
                    action()
                }
            }
    }
}
