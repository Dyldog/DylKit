//
//  File.swift
//  
//
//  Created by Dylan Elliott on 11/10/2023.
//

import Foundation

private let NOTE_SECTION_REGEX = try! NSRegularExpression(
    pattern: "(?:^(#+)\\s+(.+?)\\s+$([^#]*))",
    options: .anchorsMatchLines
)

public extension Note {
    var sections: [NoteSection] {
        let matches = NOTE_SECTION_REGEX.matches(in: contents, range: .init(location: 0, length: contents.count))
        return matches.map {
            .init(
                level: contents.substring(with: $0.range(at: 1)).count,
                title: contents.substring(with: $0.range(at: 2)),
                contents: contents.substring(with: $0.range(at: 3))
            )
        }
    }
    
    func replaceSection(at index: Int, with newSection: NoteSection) -> Note {
        var existing = sections
        existing[index] = newSection
        
        return .init(
            path: path,
            title: title,
            contents: existing
                .map(\.textRepresentation)
                .joined()
                .trimmingCharacters(in: .whitespaces)
                .appending("\n\n")
        )
    }
    
    func replaceSectionContents(at index: Int, with newContents: String) -> Note {
        let existing = sections[index]
        return replaceSection(at: index, with: .init(
            level: existing.level,
            title: existing.title,
            contents: newContents
        ))
    }
}

