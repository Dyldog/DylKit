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
    
    static var actualYellow: Color {
        .init(uiColor: .yellow)
    }
    
    static var actualGreen: Color {
        .init(uiColor: .green)
    }
}

public extension ShapeStyle where Self == Color {
    static var lightBlue: Color { .lightBlue }
    static var actualYellow: Color { .actualYellow }
    static var actualGreen: Color { .actualGreen }
}
