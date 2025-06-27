//
//  View+If.swift
//  MovieCal
//
//  Created by Dylan Elliott on 21/2/2023.
//

import Foundation
import SwiftUI

public extension View {
    @ViewBuilder
    func `if`<Out: View>(_ condition: Bool, @ViewBuilder modified: (Self) -> Out) -> some View {
        if condition {
            modified(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func `if`<If: View, Else: View>(
        _ condition: Bool,
        ifModifier: (Self) -> If,
        else: (Self) -> Else
    ) -> some View {
        if condition {
            ifModifier(self)
        } else {
            `else`(self)
        }
    }
    
    @ViewBuilder
    func `if`<T, Out: View>(_ value: T?, modified: (Self, T) -> Out) -> some View {
        if let value = value {
            modified(self, value)
        } else {
            self
        }
    }
}
