//
//  File.swift
//  
//
//  Created by Dylan Elliott on 11/10/2023.
//

import Foundation

public extension NSRegularExpression {
    func matches(in string: String, options: NSRegularExpression.MatchingOptions = []) -> [NSTextCheckingResult] {
        matches(in: string, options: options, range: .init(location: 0, length: string.count))
    }
}
