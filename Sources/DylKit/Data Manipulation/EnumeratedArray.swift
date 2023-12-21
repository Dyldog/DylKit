//
//  File.swift
//  
//
//  Created by Dylan Elliott on 19/12/2023.
//

import Foundation

public extension Array {
    func enumeratedArray() -> [(offset: Int, element: Element)] {
        return enumerated().map { ($0.offset, $0.element) }
    }
}
