//
//  File.swift
//  
//
//  Created by Dylan Elliott on 12/9/2023.
//

import SwiftUI

public extension ForEach where Content : View {
    init<T: RandomAccessCollection>(enumerated data: T, @ViewBuilder content: @escaping (Int, T.Element) -> Content) where Data == Array<(offset: Int, element: T.Element)>, ID == Int {
        self.init(Array(data.enumerated()), id: \.offset, content: content)
    }
    
    init<T: RandomAccessCollection>(_ data: T, @ViewBuilder content: @escaping (T.Element) -> Content) where Data == Array<(offset: Int, element: T.Element)>, ID == Int {
        self.init(Array(data.enumerated()), id: \.offset, content: { _, element in content(element) })
    }
}
