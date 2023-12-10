//
//  VHStack.swift
//  AppApp
//
//  Created by Dylan Elliott on 21/11/2023.
//

import SwiftUI

public struct Stack<Content: View>: View {
    let axis: Axis
    @ViewBuilder var content: () -> Content
    
    public init(axis: Axis, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content
    }

    public var body: some View {
        if axis == .vertical {
            VStack(content: content)
        } else {
            HStack(content: content)
        }
    }
}


public struct VHStack<Content: View>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ViewBuilder var content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        if horizontalSizeClass == .compact {
            VStack(content: content)
        } else {
            HStack(content: content)
        }
    }
}
