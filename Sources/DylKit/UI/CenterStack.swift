//
//  File.swift
//  
//
//  Created by Dylan Elliott on 19/11/2023.
//

import SwiftUI

public struct CenterStack<Content: View>: View {
    let content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                content()
                Spacer()
            }
            Spacer()
        }
    }
}
