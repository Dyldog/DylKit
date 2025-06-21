//
//  File.swift
//  
//
//  Created by Dylan Elliott on 11/10/2023.
//

import Foundation

public extension String {
    func withPrefix(_ prefix: String) -> String {
        guard !self.hasPrefix(prefix) else { return self }
        return prefix + self
    }
    
    func removingPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) {
            return String(self.dropFirst(prefix.count))
        } else {
            return self
        }
    }
    
    func removingSuffix(_ suffix: String) -> String {
        if self.hasSuffix(suffix) {
            return String(self.dropLast(suffix.count))
        } else {
            return self
        }
    }
}
