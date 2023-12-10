//
//  Binding+Nil.swift
//  AppApp
//
//  Created by Dylan Elliott on 24/11/2023.
//

import SwiftUI

public extension Binding {
    static func `nil`<T>() -> Self where Value == Optional<T> {
        .init {
            nil
        } set: { _ in
            
        }
    }
}
