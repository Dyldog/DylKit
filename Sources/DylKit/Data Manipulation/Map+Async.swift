//
//  File.swift
//  
//
//  Created by Dylan Elliott on 20/10/2023.
//

import Foundation

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}

public extension Optional {
    func asyncMap<T>(
        _ transform: (Wrapped) async throws -> T
    ) async rethrows -> T? {
        switch self {
        case .none: return nil
        case let .some(wrapped): return try await transform(wrapped)
        }
    }
}
