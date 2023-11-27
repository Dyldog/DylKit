//
//  File 2.swift
//  
//
//  Created by Dylan Elliott on 26/11/2023.
//

import Foundation

public extension Array {
    subscript(looping index: Int) -> Element {
        self[index % count]
    }
}
