//
//  File.swift
//  
//
//  Created by Dylan Elliott on 11/10/2023.
//

import Foundation

public extension NSRegularExpression {
    func firstMatch(in string: String, options: NSRegularExpression.MatchingOptions = []) -> NSTextCheckingResult? {
        firstMatch(in: string, options: options, range: .init(location: 0, length: string.count))
    }
    func matches(in string: String, options: NSRegularExpression.MatchingOptions = []) -> [NSTextCheckingResult] {
        matches(in: string, options: options, range: .init(location: 0, length: string.count))
    }
    
    func firstMatchGroups(in string: String, options: NSRegularExpression.MatchingOptions = []) -> [String] {
        guard let match = firstMatch(in: string, options: options, range: .init(location: 0, length: string.count)) else { return [] }
        return (1 ..< match.numberOfRanges).map {
            string.substring(with: match.range(at: $0))
        }
    }
    
    func allMatchGroups(in string: String, options: NSRegularExpression.MatchingOptions = []) -> [String] {
        let matches = matches(in: string, options: options, range: .init(location: 0, length: string.count))
            
        return matches.flatMap { match in
            (1 ..< match.numberOfRanges).map {
                string.substring(with: match.range(at: $0))
            }
        }
    }
}
