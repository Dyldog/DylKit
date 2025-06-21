//
//  File.swift
//  
//
//  Created by Dylan Elliott on 11/10/2023.
//

import Foundation

public struct NoteSection {
    public let level: Int
    public let title: String
    public let contents: String
}

extension NoteSection {
    public var lines: [String] {
        contents
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: "\n")
    }
    var textRepresentation: String {
        var paddedContents = contents
        
        if paddedContents.hasPrefix("\n") == false {
            paddedContents = "\n\n" + paddedContents
        }
        
        return """
        \(String(repeating: "#", count: level)) \(title) \(paddedContents)
        """
    }
}
