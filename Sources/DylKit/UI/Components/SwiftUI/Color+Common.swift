//
//  File.swift
//  
//
//  Created by Dylan Elliott on 13/6/2025.
//

import SwiftUI

public extension Color {
    static var lightBlue: Color {
        Color(hex: "#ade6e6")
    }
}

public extension ShapeStyle where Self == Color {
    static var lightBlue: Color { .lightBlue }
}
