//
//  Debounce.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/26/24.
//

import Foundation

public final class Debouncer {
    private let dueTime: UInt64 = 0
    private var task: Task<Void, Error>?

    public func execute(action: @escaping () async throws -> Void) {
        self.task?.cancel()
        self.task = Task { [weak self] in
            guard let self else { return }
            try? await Task.sleep(nanoseconds: self.dueTime)
            guard !Task.isCancelled else { return }
            try await action()
        }
    }
}
