//
//  Color+Rainbow.swift
//  Busy
//
//  Created by Dylan Elliott on 15/6/2023.
//

import SwiftUI

public extension Color {
    static var rainbowColors: [Color] {
        [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
    }
}
//
//struct RepeatingArray<Element>: RandomAccessCollection {
//    let values: [Element]
//    
//    func makeIterator() -> some IteratorProtocol {
//        IndexingIterator(_elements: values)
//    }
//}
