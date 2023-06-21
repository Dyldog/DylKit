//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2023.
//

import Foundation

public extension Array {
    func rotated(_ offset: Int) -> Self {
        let offset = offset % count
        return Array(self[offset...] + self[...offset])
    }
}
