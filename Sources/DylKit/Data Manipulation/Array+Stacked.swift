//
//  File.swift
//  
//
//  Created by Dylan Elliott on 12/6/2025.
//

import SwiftUI

public extension Array {
    func hStacked<Content: View>(_ content: @escaping (Element) -> Content) -> some View {
        HStack {
            ForEach(self) {
                content($0)
            }
        }
    }
    
    func vStacked<Content: View>(_ content: @escaping (Element) -> Content) -> some View {
        VStack {
            ForEach(self) {
                content($0)
            }
        }
    }
    
    @ViewBuilder
    func stacked<Content: View>(_ axis: Axis, _ content: @escaping (Element) -> Content) -> some View {
        switch axis {
        case .vertical: vStacked(content)
        case .horizontal: hStacked(content)
        }
    }
}
