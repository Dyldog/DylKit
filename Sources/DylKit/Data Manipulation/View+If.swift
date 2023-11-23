//
//  View+If.swift
//  MovieCal
//
//  Created by Dylan Elliott on 21/2/2023.
//

import Foundation
import SwiftUI

public extension View {
    func `if`(_ condition: Bool, modified: (Self) -> any View) -> AnyView {
        if condition {
            return AnyView(modified(self))
        } else {
            return AnyView(self)
        }
    }
    
    func `if`<T>(_ value: T?, modified: (Self, T) -> any View) -> AnyView {
        if let value = value {
            return AnyView(modified(self, value))
        } else {
            return AnyView(self)
        }
    }
}
