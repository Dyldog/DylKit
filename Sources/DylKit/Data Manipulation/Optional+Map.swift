//
//  Optional+Mapped.swift
//  MovieCal
//
//  Created by Dylan Elliott on 21/2/2023.
//

import Foundation

extension Optional {
    func map<T>(_ mapper: (Wrapped) -> T?) -> T? {
        switch self {
        case .none: return nil
        case .some(let wrapped): return mapper(wrapped)
        }
    }
}

