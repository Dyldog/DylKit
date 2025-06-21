//
//  File.swift
//  
//
//  Created by Dylan Elliott on 8/6/2025.
//

import Foundation

extension Array {
    func chop(at index: Int) -> (Self, Self) {
        return (self[0 ..< index].array, self[index...].array)
    }
    
    func chop(atFirstIndexWhere checker: (Element) -> Bool) -> (Self, Self) {
        guard let index = self.firstIndex(where: { checker($0) }) else { return ([], self) }
        
        return chop(at: index)
    }
}
