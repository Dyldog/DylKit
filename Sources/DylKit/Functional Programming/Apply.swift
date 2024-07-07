//
//  File.swift
//  
//
//  Created by Dylan Elliott on 7/7/2024.
//

import Foundation

public protocol Applicable { }

public extension Applicable {
    func apply<T>(_ work: (Self) -> T) -> T {
        work(self)
    }
}

import SwiftUI

public extension View {
    func apply<T>(_ work: (Self) -> T) -> T {
        work(self)
    }
}
