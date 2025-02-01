//
//  File.swift
//
//
//  Created by Dylan Elliott on 18/8/2024.
//

import Foundation
import SwiftUI

public extension Optional {
    func ifSome(_ work: (Wrapped) -> Void) -> Void {
        if let self {
            work(self)
        }
    }
    
//    func ifSome<T>(_ someContent: (Wrapped) -> T, ifNone noneContent: () -> T) -> T {
//        switch self {
//        case .none: noneContent()
//        case .some(let value): someContent(value)
//        }
//    }
    
    @ViewBuilder
    func ifSome(_ someContent: (Wrapped) -> some View, ifNone noneContent: () -> some View) -> some View {
        switch self {
        case .none: noneContent()
        case .some(let value): someContent(value)
        }
    }
}

@ViewBuilder
public func ifSome<T>(_ value: T?, _ someContent: (T) -> some View, ifNone noneContent: () -> some View) -> some View {
    switch value {
    case .none: noneContent()
    case .some(let value): someContent(value)
    }
}
