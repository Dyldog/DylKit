//
//  File.swift
//  
//
//  Created by Dylan Elliott on 23/6/2025.
//

import SwiftUI

public struct TagLabel: View {
    let text: String
    let color: Color
    
    public init(_ text: String, color: Color) {
        self.text = text
        self.color = color
    }
    
    public var body: some View {
        Text(text)
            .bold()
            .padding(.horizontal, 6)
            .foregroundStyle(.white)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(color)
            }
    }
}
