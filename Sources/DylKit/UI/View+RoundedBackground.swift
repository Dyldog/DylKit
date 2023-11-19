//
//  File.swift
//  
//
//  Created by Dylan Elliott on 19/11/2023.
//

import SwiftUI

public extension View {
    func roundedBackground(radius: Int, color: Color) -> some View {
        self.background {
            RoundedRectangle(cornerRadius: CGFloat(radius)).foregroundStyle(color)
        }
    }
}
